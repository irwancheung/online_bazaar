import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/core/exceptions/cart_exception.dart';
import 'package:online_bazaar/core/network_info.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/data/data_sources/customer_cart_data_source.dart';
import 'package:online_bazaar/features/customer/data/models/cart_item_model.dart';
import 'package:online_bazaar/features/customer/data/models/cart_model.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart_item.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_cart_repository.dart';
import 'package:online_bazaar/features/shared/data/models/menu_item_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';

class CustomerCartRepositoryImpl implements CustomerCartRepository {
  final NetworkInfo _networkInfo;
  final CustomerCartDataSource _dataSource;

  const CustomerCartRepositoryImpl({
    required NetworkInfo networkInfo,
    required CustomerCartDataSource dataSource,
  })  : _networkInfo = networkInfo,
        _dataSource = dataSource;

  @override
  Future<Cart> setCartCustomer(SetCartCustomerParams params) async {
    try {
      return CartModel.fromEntity(params.cart).copyWith(
        customer: params.customer,
        updatedAt: DateTime.now(),
      );
    } catch (e, s) {
      logger.error(e, s);

      throw const SetCartCustomerException();
    }
  }

  @override
  Future<Cart> addCartItem(AddCartItemParams params) async {
    try {
      final cart = params.cart;
      final item = params.item;
      final variant = params.variant;
      final quantity = params.quantity;
      final note = params.note;

      final existingCartItem = cart.items.firstWhereOrNull(
        (e) => e.item.id == item.id && e.variant == variant,
      );

      final now = DateTime.now();
      late CartItemModel newCartItem;

      if (existingCartItem != null) {
        newCartItem = CartItemModel.fromEntity(existingCartItem).copyWith(
          item: item,
          quantity: existingCartItem.quantity + quantity,
          note: note,
          updatedAt: now,
        );
      } else {
        newCartItem = CartItemModel(
          id: now.millisecondsSinceEpoch.toString(),
          item: item,
          variant: variant,
          quantity: quantity,
          note: note,
          createdAt: now,
        );
      }

      final newCart = CartModel.fromEntity(cart).copyWith(
        items: [
          ...cart.items.where(
            (e) => e.item.id != item.id || e.variant != variant,
          ),
          newCartItem,
        ],
      );

      final exception = _validateCartItems(newCart.items);
      if (exception != null) {
        throw AddCartItemException(exception.message);
      }

      return _recalculateCart(newCart);
    } on AppException {
      rethrow;
    } catch (e, s) {
      logger.error(e, s);
      throw const AddCartItemException();
    }
  }

  @override
  Future<Cart> updateCartItem(UpdateCartItemParams params) async {
    try {
      final cart = params.cart;
      final cartItemId = params.cartItemId;
      final variant = params.variant;
      final quantity = params.quantity;
      final note = params.note;

      final existingCartItem = cart.items.firstWhereOrNull(
        (e) => e.id == cartItemId,
      );

      if (existingCartItem == null) {
        throw const UpdateCartItemException('Item tidak ditemukan.');
      }

      final newCartItem = CartItemModel.fromEntity(existingCartItem).copyWith(
        variant: variant,
        quantity: quantity,
        note: note,
        updatedAt: DateTime.now(),
      );

      final newCart = CartModel.fromEntity(cart).copyWith(
        items: [
          ...cart.items.where((e) => e.id != cartItemId),
          newCartItem,
        ],
      );

      final exception = _validateCartItems(newCart.items);
      if (exception != null) {
        throw UpdateCartItemException(exception.message);
      }

      return _recalculateCart(newCart);
    } on AppException {
      rethrow;
    } catch (e, s) {
      logger.error(e, s);
      throw const UpdateCartItemException();
    }
  }

  @override
  Future<Cart> removeCartItem(RemoveCartItemParams params) async {
    try {
      final cart = params.cart;
      final cartItemId = params.cartItemId;

      final newCart = CartModel.fromEntity(cart).copyWith(
        items: cart.items.where((e) => e.id != cartItemId).toList(),
      );

      final exception = _validateCartItems(newCart.items);
      if (exception != null) {
        throw RemoveCartItemException(exception.message);
      }

      return _recalculateCart(newCart);
    } on AppException {
      rethrow;
    } catch (e, s) {
      logger.error(e, s);
      throw const RemoveCartItemException();
    }
  }

  @override
  Future<Cart> validateCart(ValidateCartParams params) async {
    try {
      await _networkInfo.checkConnection();

      bool canCheckout = true;

      final cart = params.cart;
      final cartItems = cart.items;

      if (cart.customer == null) {
        canCheckout = false;
      }

      final items = await _dataSource
          .getMenuItemsByCartItemIds(cartItems.map((e) => e.item.id).toList());

      final newCartItems = cartItems.map((cartItem) {
        final item = items.firstWhereOrNull((i) => i.id == cartItem.item.id);

        if (item == null) {
          canCheckout = false;

          return CartItemModel.fromEntity(cartItem).copyWith(
            item: MenuItemModel.fromEntity(cartItem.item).copyWith(
              remainingQuantity: 0,
            ),
            updatedAt: DateTime.now(),
          );
        }

        if (!_isVariantValid(cartItem.variant, item.variants) ||
            !_isQuantityEnough(cartItem.quantity, item.remainingQuantity)) {
          canCheckout = false;
        }

        return CartItemModel.fromEntity(cartItem).copyWith(
          item: item,
          updatedAt: DateTime.now(),
        );
      }).toList();

      final newCart = CartModel.fromEntity(cart).copyWith(
        items: newCartItems,
        canCheckout: canCheckout,
        updatedAt: DateTime.now(),
      );

      return _recalculateCart(newCart);
    } on AppException {
      rethrow;
    } catch (e, s) {
      logger.error(e, s);
      throw const ValidateCartException();
    }
  }

  @override
  Future<FoodOrder> completeCheckout(CompleteCheckoutParams params) async {
    try {
      await _networkInfo.checkConnection();

      // validate bazaar period
      final now = DateTime.now();
      final startAt = params.setting.event.startAt!;
      final endAt = params.setting.event.endAt!;

      if (now.isBefore(startAt) || now.isAfter(endAt)) {
        throw const CompleteCheckoutException('Bazaar belum dimulai.');
      }

      final forCheckoutCart = CartModel.fromEntity(params.cart).copyWith(
        orderType: params.orderType,
        paymentType: params.paymentType,
        deliveryAddress: params.deliveryAddress,
        note: params.note,
      );

      final updatedParams = params.copyWith(cart: forCheckoutCart);

      return await _dataSource.convertCartToFoodOrder(updatedParams);
    } on AppException {
      rethrow;
    } catch (e, s) {
      logger.error(e, s);
      throw const CompleteCheckoutException();
    }
  }

  Cart _recalculateCart(Cart cart) {
    final newCart = CartModel.fromEntity(cart).copyWith(
      items: cart.items.where((e) => e.quantity > 0).toList(),
    );

    newCart.items.sort((a, b) => a.id.compareTo(b.id));

    final totalQuantity = newCart.items.fold<int>(
      0,
      (previousValue, e) => previousValue + e.quantity,
    );

    final totalPrice = newCart.items.fold<int>(
      0,
      (previousValue, e) => previousValue + e.item.sellingPrice * e.quantity,
    );

    return CartModel.fromEntity(newCart).copyWith(
      totalQuantity: totalQuantity,
      totalPrice: totalPrice,
      updatedAt: DateTime.now(),
    );
  }

  ValidateCartException? _validateCartItems(List<CartItem> cartItems) {
    for (final cartItem in cartItems) {
      final quantity =
          cartItems.where((e) => e.item.id == cartItem.item.id).fold<int>(
                0,
                (previousValue, e) => previousValue + e.quantity,
              );

      if (!_isQuantityEnough(quantity, cartItem.item.remainingQuantity)) {
        return const ValidateCartException('Stok tidak cukup.');
      }

      if (!_isVariantValid(cartItem.variant, cartItem.item.variants)) {
        return const ValidateCartException('Varian tidak valid.');
      }
    }

    return null;
  }

  bool _isQuantityEnough(int quantity, int remainingQuantity) {
    return quantity <= remainingQuantity;
  }

  bool _isVariantValid(String variant, List<String> variants) {
    if (variants.isNotEmpty && !variants.contains(variant)) {
      return false;
    }

    if (variants.isEmpty && variant.isNotEmpty) {
      return false;
    }

    return true;
  }
}
