import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_cart_repository.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_repository.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cart_cubit.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cubit.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_elevated_button.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/loading_indicator.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/underline_text_field.dart';

class CustomerProfileForm extends StatefulWidget {
  const CustomerProfileForm({super.key});

  @override
  State<CustomerProfileForm> createState() => _CustomerProfileFormState();
}

class _CustomerProfileFormState extends State<CustomerProfileForm> {
  static const _nameField = 'name';
  static const _emailField = 'email';
  static const _chaityaField = 'chaitya';
  static const _phoneField = 'phone';
  static const _addressField = 'address';

  final _formKey = GlobalKey<FormBuilderState>();

  void _updateProfile() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final name = _formKey.currentState!.fields[_nameField]!.value as String;
      final email =
          _formKey.currentState!.fields[_emailField]!.value as String? ?? '';
      final chaitya =
          _formKey.currentState!.fields[_chaityaField]!.value as String;
      final phone = _formKey.currentState!.fields[_phoneField]!.value as String;
      final address =
          _formKey.currentState!.fields[_addressField]!.value as String;

      context.read<CustomerCubit>().setCustomer(
            SetCustomerParams(
              name: name,
              email: email,
              chaitya: chaitya,
              phone: phone,
              address: address,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerState>(
      listener: (context, state) {
        if (state is SetCustomerFailureState) {
          context.showErrorSnackBar(state.errorMessage!);
        }

        if (state is SetCustomerSuccessState) {
          context.read<CustomerCartCubit>().setCartCustomer(
                SetCartCustomerParams(
                  cart: context.read<CustomerCartCubit>().state.cart,
                  customer: state.customer!,
                ),
              );

          context.showSnackBar('Berhasil menyimpan data profil!');
        }
      },
      builder: (context, state) {
        final customer = state.customer;

        return FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UnderlineTextField(
                  name: _nameField,
                  label: 'Nama',
                  initialValue: customer?.name,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(5),
                    FormBuilderValidators.maxLength(50),
                  ]),
                ),
                20.h.height,
                UnderlineTextField(
                  name: _emailField,
                  label: 'Email',
                  initialValue: customer?.email,
                  hintText: 'Opsional',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(),
                  ]),
                ),
                20.h.height,
                UnderlineTextField(
                  name: _chaityaField,
                  label: 'Cetya',
                  initialValue: customer?.chaitya,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(5),
                    FormBuilderValidators.maxLength(20),
                  ]),
                ),
                20.h.height,
                UnderlineTextField(
                  name: _phoneField,
                  label: 'Nomor HP',
                  initialValue: customer?.phone,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.minLength(10),
                    FormBuilderValidators.maxLength(15),
                  ]),
                ),
                20.h.height,
                UnderlineTextField(
                  name: _addressField,
                  label: 'Alamat Pengiriman',
                  initialValue: customer?.address,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(10),
                    FormBuilderValidators.maxLength(100),
                  ]),
                ),
                20.h.height,
                BlocBuilder<CustomerCubit, CustomerState>(
                  builder: (context, state) {
                    if (state is SetCustomerLoadingState) {
                      return const LoadingIndicator();
                    }

                    return AppElevatedButton(
                      label: 'Simpan',
                      onPressed: _updateProfile,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
