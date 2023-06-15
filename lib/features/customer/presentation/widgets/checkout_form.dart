import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/domain/entities/cart.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_cart_repository.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cart_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_setting_cubit.dart';
import 'package:online_bazaar/features/shared/data/models/delivery_address_model.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_elevated_button.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/form_dropdown.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/underline_text_field.dart';

class CheckoutForm extends StatefulWidget {
  final Cart cart;
  const CheckoutForm({super.key, required this.cart});

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  static const _noteField = 'note';
  static const _orderTypeField = 'orderType';
  static const _paymentTypeField = 'paymentType';
  static const _deliveryNameField = 'deliveryName';
  static const _deliveryAddressField = 'deliveryAddress';
  static const _deliveryPhoneField = 'deliveryPhone';

  final _formKey = GlobalKey<FormBuilderState>();
  final _showAddressFieldNotifier = ValueNotifier<bool>(false);

  Future<void> _completeCheckout() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final note =
          _formKey.currentState?.fields[_noteField]?.value as String? ?? '';
      final paymentTypeStr =
          _formKey.currentState?.fields[_paymentTypeField]?.value as String;
      final orderTypeStr =
          _formKey.currentState?.fields[_orderTypeField]?.value as String;

      DeliveryAddressModel? deliveryAddress;

      if (_showAddressFieldNotifier.value) {
        final name =
            _formKey.currentState?.fields[_deliveryNameField]?.value as String;
        final address = _formKey
            .currentState?.fields[_deliveryAddressField]?.value as String;
        final phone =
            _formKey.currentState?.fields[_deliveryPhoneField]?.value as String;

        deliveryAddress = DeliveryAddressModel.fromCheckoutForm(
          name: name,
          address: address,
          phone: phone,
        );
      }

      final setting = context.read<CustomerSettingCubit>().state.setting!;

      final params = CompleteCheckoutParams(
        cart: context.read<CustomerCartCubit>().state.cart,
        note: note,
        deliveryAddress: deliveryAddress,
        paymentType:
            PaymentType.values.firstWhere((e) => e.name == paymentTypeStr),
        orderType: OrderType.values.firstWhere((e) => e.name == orderTypeStr),
        setting: setting,
      );

      context.read<CustomerCartCubit>().completeCheckout(params);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;
    final customer = widget.cart.customer;

    if (cart.items.isEmpty) {
      return Center(
        child: appText.body(
          'Belum ada barang di keranjang.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return FormBuilder(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  UnderlineTextField(
                    name: _noteField,
                    label: 'Catatan',
                    hintText: 'Opsional',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.maxLength(100),
                    ]),
                  ),
                  20.h.height,
                  FormDropDown(
                    name: _paymentTypeField,
                    label: 'Metode Pembayaran',
                    initialValue: PaymentType.bankTransfer.name,
                    items: [
                      DropdownMenuItem(
                        value: PaymentType.bankTransfer.name,
                        child: appText.body('Transfer'),
                      ),
                      DropdownMenuItem(
                        value: PaymentType.cash.name,
                        child: appText.body('Tunai'),
                      ),
                    ],
                  ),
                  20.h.height,
                  FormDropDown(
                    name: _orderTypeField,
                    label: 'Metode Pengiriman',
                    initialValue: OrderType.pickup.name,
                    onChanged: (value) => _showAddressFieldNotifier.value =
                        value == OrderType.delivery.name,
                    items: [
                      DropdownMenuItem(
                        value: OrderType.pickup.name,
                        child: appText.body('Ambil di tempat'),
                      ),
                      DropdownMenuItem(
                        value: OrderType.delivery.name,
                        child: appText.body('Antar ke alamat'),
                      ),
                    ],
                  ),
                  ValueListenableBuilder(
                    valueListenable: _showAddressFieldNotifier,
                    builder: (
                      BuildContext context,
                      bool showAddressField,
                      Widget? child,
                    ) {
                      if (showAddressField) {
                        return Column(
                          children: [
                            20.h.height,
                            UnderlineTextField(
                              name: _deliveryNameField,
                              label: 'Nama penerima',
                              initialValue: customer!.name,
                              validator: _showAddressFieldNotifier.value
                                  ? FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ])
                                  : null,
                            ),
                            20.h.height,
                            UnderlineTextField(
                              name: _deliveryAddressField,
                              label: 'Alamat penerima',
                              initialValue: customer.address,
                              validator: _showAddressFieldNotifier.value
                                  ? FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ])
                                  : null,
                            ),
                            20.h.height,
                            UnderlineTextField(
                              name: _deliveryPhoneField,
                              label: 'Nomor telepon penerima',
                              initialValue: customer.phone,
                              validator: _showAddressFieldNotifier.value
                                  ? FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ])
                                  : null,
                            ),
                          ],
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
          20.h.height,
          if (!cart.canCheckout)
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: appText.caption(
                'Tidak bisa membuat pesanan.\nMohon periksa kembali keranjang Anda.',
                color: Theme.of(context).colorScheme.error,
                textAlign: TextAlign.center,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appText.body('Total', fontWeight: FontWeight.w600),
              appText.body(cart.totalPrice.toCurrencyFormat()),
            ],
          ),
          20.h.height,
          AppElevatedButton(
            label: 'Pesan',
            onPressed: cart.canCheckout ? _completeCheckout : null,
          ),
        ],
      ),
    );
  }
}
