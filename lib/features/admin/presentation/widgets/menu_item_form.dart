import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:online_bazaar/core/input_formatters/currency_formatter.dart';
import 'package:online_bazaar/core/input_formatters/numeric_formatter.dart';
import 'package:online_bazaar/core/validators/form_validator.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_menu_repository.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_menu_cubit.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_elevated_button.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/image_picker_field.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/loading_indicator.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/underline_text_field.dart';

class MenuItemForm extends StatefulWidget {
  final MenuItem? item;

  const MenuItemForm({super.key, this.item});

  @override
  State<MenuItemForm> createState() => _MenuItemFormState();
}

class _MenuItemFormState extends State<MenuItemForm> {
  static const _nameField = 'name';
  static const _imageField = 'image';
  static const _priceField = 'price';
  static const _quantityField = 'quantity';
  static const _variantField = 'variant';

  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> _submitItem() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final name = _formKey.currentState!.fields[_nameField]!.value as String;
      final image = _formKey.currentState!.fields[_imageField]!.value as String;
      final price = _formKey.currentState!.fields[_priceField]!.value as String;
      final quantity =
          _formKey.currentState!.fields[_quantityField]!.value as String;
      final variant =
          _formKey.currentState!.fields[_variantField]!.value as String? ?? '';

      final variants = List<String>.from(
        variant
            .trim()
            .split(',')
            .where((e) => e.isNotEmpty)
            .map((e) => e.trim()),
      );

      if (widget.item != null) {
        final params = UpdateMenuItemParams(
          id: widget.item!.id,
          name: name.trim(),
          image: image,
          sellingPrice: price.toInteger(),
          remainingQuantity: int.parse(quantity),
          variants: variants,
        );

        context.read<AdminMenuCubit>().updateMenuItem(params);
        return;
      }

      final params = AddMenuItemParams(
        name: name.trim(),
        image: image,
        sellingPrice: price.toInteger(),
        remainingQuantity: int.parse(quantity),
        variants: variants,
      );

      context.read<AdminMenuCubit>().addMenuItem(params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.r, 0, 20.r, 20.r),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImagePickerField(
                        name: _imageField,
                        radius: 50.r,
                        initialValue: widget.item?.image,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Wajib masukkan gambar.',
                          ),
                        ]),
                      ),
                    ],
                  ),
                  20.h.height,
                  UnderlineTextField(
                    label: 'Nama',
                    name: _nameField,
                    initialValue: widget.item?.name,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(5),
                      FormBuilderValidators.maxLength(50),
                    ]),
                  ),
                  20.h.height,
                  UnderlineTextField(
                    label: 'Harga',
                    name: _priceField,
                    initialValue:
                        widget.item?.sellingPrice.toCurrencyFormat() ?? 'Rp 0',
                    keyboardType: TextInputType.number,
                    inputFormatters: [CurrencyFormatter()],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormValidators.currency(min: 1000, max: 1000000),
                    ]),
                  ),
                  20.h.height,
                  UnderlineTextField(
                    label: 'Jumlah',
                    name: _quantityField,
                    initialValue:
                        widget.item?.remainingQuantity.toString() ?? '0',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      NumericFormatter(),
                    ],
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.integer(),
                      FormBuilderValidators.min(0),
                      FormBuilderValidators.max(9999),
                    ]),
                  ),
                  20.h.height,
                  UnderlineTextField(
                    label: 'Varian',
                    name: _variantField,
                    initialValue: widget.item?.variants != null
                        ? widget.item!.variants.join(', ')
                        : null,
                    helperText:
                        'Masukkan nama varian jika ada, dipisah dengan tanda koma. Contoh: Ayam, Udang, Ikan',
                    helperMaxLines: 2,
                  ),
                  // 50.h.height,
                ],
              ),
            ),
            KeyboardVisibilityBuilder(
              builder: (context, visible) =>
                  visible ? 150.h.height : 20.h.height,
            ),
            BlocConsumer<AdminMenuCubit, AdminMenuState>(
              listener: (context, state) {
                if (state is AddMenuItemFailureState) {
                  context.showErrorSnackBar(state.errorMessage!);
                }

                if (state is UpdateMenuItemFailureState) {
                  context.showErrorSnackBar(state.errorMessage!);
                }

                if (state is AddMenuItemSuccessState) {
                  context.showSnackBar('Berhasil menambahkan menu baru.');
                  context.pop();
                }

                if (state is UpdateMenuItemSuccessState) {
                  context.showSnackBar('Berhasil mengubah menu.');
                  context.pop();
                }
              },
              builder: (context, state) {
                if (state is AddMenuItemLoadingState ||
                    state is UpdateMenuItemLoadingState) {
                  return const LoadingIndicator();
                }

                return AppElevatedButton(
                  label: 'Simpan',
                  onPressed: _submitItem,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
