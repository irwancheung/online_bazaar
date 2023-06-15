import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_food_order_repository.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_food_order_cubit.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_small_elevated_button.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/loading_indicator.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/underline_text_field.dart';

class AdminNoteForm extends StatefulWidget {
  final FoodOrder foodOrder;
  const AdminNoteForm({super.key, required this.foodOrder});

  @override
  State<AdminNoteForm> createState() => _AdminNoteFormState();
}

class _AdminNoteFormState extends State<AdminNoteForm> {
  static const _noteField = 'note';

  final _formKey = GlobalKey<FormBuilderState>();

  void _updateNote() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final adminNote =
          _formKey.currentState!.fields[_noteField]!.value as String;

      context.read<AdminFoodOrderCubit>().updateAdminNote(
            UpdateAdminNoteParams(
              id: widget.foodOrder.id,
              adminNote: adminNote.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: UnderlineTextField(
              name: _noteField,
              label: 'Catatan Admin',
              initialValue: widget.foodOrder.adminNote ?? '',
            ),
          ),
          10.r.width,
          BlocConsumer<AdminFoodOrderCubit, AdminFoodOrderState>(
            listener: (context, state) {
              if (state is UpdateAdminNoteFailureState) {
                context.showErrorSnackBar(state.errorMessage!);
              }

              if (state is UpdateAdminNoteSuccessState) {
                context.showSnackBar('Catatan Admin berhasil diubah');
              }
            },
            builder: (context, state) {
              if (state is UpdateAdminNoteLoadingState) {
                return SizedBox(
                  width: 80.r,
                  height: 40.h,
                  child: const LoadingIndicator(),
                );
              }

              return SizedBox(
                width: 100.r,
                child: AppSmallElevatedButton(
                  label: 'Ubah',
                  onPressed: _updateNote,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
