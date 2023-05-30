import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_bazaar/core/enums/cart_enum.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart_item.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_cart_repository.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cart_cubit.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_elevated_button.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/rectangle_network_image.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/underline_text_field.dart';

class CartItemForm extends StatefulWidget {
  final MenuItem? item;
  final CartItem? cartItem;
  final CartAction action;

  const CartItemForm({
    super.key,
    this.item,
    this.cartItem,
    required this.action,
  }) : assert(
          (item == null && cartItem != null) ||
              (item != null && cartItem == null),
        );

  @override
  State<CartItemForm> createState() => _CartItemFormState();
}

class _CartItemFormState extends State<CartItemForm> {
  static const _quantityField = 'quantity';
  static const _variantField = 'variant';

  final _formKey = GlobalKey<FormBuilderState>();
  final _errorNorifier = ValueNotifier<String>('');

  late final MenuItem _item;
  late Cart _cart;

  List<String> _variants = [];

  @override
  void initState() {
    super.initState();

    if (widget.action == CartAction.add) {
      _item = widget.item!;
      _variants = _item.variants;
      return;
    }

    if (widget.action == CartAction.update) {
      _item = widget.cartItem!.item;

      if (widget.cartItem!.variant.isNotEmpty) {
        _variants = [widget.cartItem!.variant];
      }

      return;
    }
  }

  Future<void> _submitItem() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final quantity =
          _formKey.currentState!.fields[_quantityField]!.value as String;

      final variant =
          _formKey.currentState!.fields[_variantField]?.value as String? ?? '';

      if (widget.action == CartAction.add) {
        final params = AddCartItemParams(
          cart: _cart,
          item: _item,
          variant: variant,
          quantity: int.parse(quantity),
          note: '',
        );

        context.read<CustomerCartCubit>().addCartItem(params);
      }
      if (widget.action == CartAction.update) {
        final params = UpdateCartItemParams(
          cart: _cart,
          cartItemId: widget.cartItem!.id,
          variant: widget.cartItem!.variant,
          quantity: int.parse(quantity),
          note: '',
        );

        context.read<CustomerCartCubit>().updateCartItem(params);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<CustomerCartCubit, CustomerCartState>(
      listener: (context, state) {
        if (state is AddCartItemSuccessState) {
          context.showSnackBar('Berhasil menambahkan item ke keranjang');
          context.pop();
        }

        if (state is UpdateCartItemSuccessState) {
          context.showSnackBar('Berhasil mengubah item di keranjang');
          context.pop();
        }

        if (state is AddCartItemFailureState) {
          _errorNorifier.value = state.errorMessage!;
        }

        if (state is UpdateCartItemFailureState) {
          _errorNorifier.value = state.errorMessage!;
        }
      },
      builder: (context, state) {
        _cart = state.cart;

        return FormBuilder(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: RectangleNetworkImage(
                          url: _item.image,
                          fit: BoxFit.cover,
                          borderRadius: 10.r,
                        ),
                      ),
                      10.h.height,
                      Center(child: appText.header(_item.name)),
                      10.h.height,
                      Center(
                        child: appText
                            .caption(_item.sellingPrice.toCurrencyFormat()),
                      ),
                      10.h.height,
                      if (_variants.isNotEmpty)
                        Column(
                          children: [
                            SizedBox(
                              width: 150,
                              child: FormBuilderDropdown(
                                name: _variantField,
                                initialValue: _variants.first,
                                enabled: widget.action == CartAction.add,
                                items: _variants
                                    .map(
                                      (variant) => DropdownMenuItem(
                                        value: variant,
                                        child: appText.caption(variant),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {},
                              ),
                            ),
                            10.h.height,
                          ],
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              final value = _formKey.currentState
                                  ?.fields[_quantityField]?.value as String?;

                              final quantity = int.tryParse(value ?? '') ?? 1;

                              if (quantity > 1) {
                                _formKey.currentState?.fields[_quantityField]
                                    ?.didChange((quantity - 1).toString());
                              }
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.circleMinus,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: UnderlineTextField(
                              name: _quantityField,
                              initialValue: widget.action == CartAction.add
                                  ? '1'
                                  : widget.cartItem!.quantity.toString(),
                              textAlign: TextAlign.center,
                              enabled: false,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              final value = _formKey.currentState
                                  ?.fields[_quantityField]?.value as String?;

                              final quantity = int.tryParse(value ?? '') ?? 1;

                              if (quantity < 99) {
                                _formKey.currentState?.fields[_quantityField]
                                    ?.didChange((quantity + 1).toString());
                              }
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.circlePlus,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                20.h.height,
                ValueListenableBuilder(
                  valueListenable: _errorNorifier,
                  builder:
                      (BuildContext context, String message, Widget? child) {
                    if (message.isNotEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: appText.caption(
                          message,
                          color: theme.colorScheme.error,
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                AppElevatedButton(
                  label: widget.action == CartAction.add
                      ? 'Tambahkan ke Keranjang'
                      : 'Simpan',
                  onPressed: _submitItem,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
