import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/data/models/cart_model.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_cart_repository.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';

part 'customer_cart_state.dart';

class CustomerCartCubit extends HydratedCubit<CustomerCartState> {
  final CustomerCartRepository _repository;

  CustomerCartCubit({required CustomerCartRepository repository})
      : _repository = repository,
        super(CustomerCartState(cart: CartModel.newCart()));

  Future<void> setCartCustomer(SetCartCustomerParams customer) async {
    try {
      emit(SetCartCustomerLoadingState(cart: state.cart));

      final cart = await _repository.setCartCustomer(customer);

      emit(SetCartCustomerSuccessState(cart: cart));
    } on AppException catch (e) {
      emit(
        SetCartCustomerFailureState(
          cart: state.cart,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> addCartItem(AddCartItemParams params) async {
    try {
      emit(AddCartItemLoadingState(cart: state.cart));

      final cart = await _repository.addCartItem(params);

      emit(AddCartItemSuccessState(cart: cart));
    } on AppException catch (e) {
      emit(AddCartItemFailureState(cart: state.cart, errorMessage: e.message));
    }
  }

  Future<void> updateCartItem(UpdateCartItemParams params) async {
    try {
      emit(UpdateCartItemLoadingState(cart: state.cart));

      final cart = await _repository.updateCartItem(params);

      emit(UpdateCartItemSuccessState(cart: cart));
    } on AppException catch (e) {
      emit(
        UpdateCartItemFailureState(
          cart: state.cart,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> removeCartItem(RemoveCartItemParams params) async {
    try {
      emit(RemoveCartItemLoadingState(cart: state.cart));

      final cart = await _repository.removeCartItem(params);

      emit(RemoveCartItemSuccessState(cart: cart));
    } on AppException catch (e) {
      emit(
        RemoveCartItemFailureState(
          cart: state.cart,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> validateCart() async {
    try {
      emit(ValidateCartLoadingState(cart: state.cart));

      final cart =
          await _repository.validateCart(ValidateCartParams(cart: state.cart));

      emit(ValidateCartSuccessState(cart: cart));
    } on AppException catch (e) {
      emit(ValidateCartFailureState(cart: state.cart, errorMessage: e.message));
    }
  }

  Future<void> completeCheckout(CompleteCheckoutParams params) async {
    try {
      emit(CompleteCheckoutLoadingState(cart: state.cart));

      final foodOrder = await _repository.completeCheckout(params);
      final newCart =
          CartModel.newCart().copyWith(customer: params.cart.customer);

      emit(CompleteCheckoutSuccessState(foodOrder: foodOrder, cart: newCart));
    } on AppException catch (e) {
      emit(
        CompleteCheckoutFailureState(
          cart: state.cart,
          errorMessage: e.message,
        ),
      );
    }
  }

  @override
  CustomerCartState? fromJson(Map<String, dynamic> json) {
    try {
      return CustomerCartState.fromMap(json);
    } catch (e, s) {
      logger.error(e, s);
      return CustomerCartState(cart: CartModel.newCart());
    }
  }

  @override
  Map<String, dynamic>? toJson(CustomerCartState state) {
    try {
      return state.toMap();
    } catch (e, s) {
      logger.error(e, s);
      return CustomerCartState(cart: CartModel.newCart()).toMap();
    }
  }
}
