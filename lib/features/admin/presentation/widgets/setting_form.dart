import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:online_bazaar/core/input_formatters/all_caps_formatter.dart';
import 'package:online_bazaar/core/validators/form_validator.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_setting_repository.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_setting_cubit.dart';
import 'package:online_bazaar/features/shared/domain/entities/setting.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_elevated_button.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/date_picker_field.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/loading_indicator.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/underline_text_field.dart';

class SettingForm extends StatefulWidget {
  final Setting setting;

  const SettingForm({super.key, required this.setting});

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm>
    with SingleTickerProviderStateMixin {
  static const _eventNameField = 'eventName';
  static const _eventPickupNoteField = 'eventPickupNote';
  static const _eventStartAtField = 'eventStartAt';
  static const _eventEndAtField = 'eventEndAt';
  static const _orderNumberPrefixField = 'orderNumberPrefix';
  static const _transferToField = 'transferTo';
  static const _transferNoteFormatField = 'transferNoteFormat';
  static const _sendTransferProofToField = 'sendTransferProofTo';

  final _formKey = GlobalKey<FormBuilderState>();

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _updateSetting() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      bool isFormValid = true;

      final formValues = _formKey.currentState!.value;

      if (formValues.length < 8) {
        isFormValid = false;
      } else {
        formValues.forEach((key, value) {
          switch (key) {
            case _eventNameField:
              if (value == null) {
                isFormValid = false;
              }
            case _eventPickupNoteField:
              if (value == null) {
                isFormValid = false;
              }
            case _eventStartAtField:
              if (value == null) {
                isFormValid = false;
              }
            case _eventEndAtField:
              if (value == null) {
                isFormValid = false;
              }
            case _orderNumberPrefixField:
              if (value == null) {
                isFormValid = false;
              }
            case _transferToField:
              if (value == null) {
                isFormValid = false;
              }
            case _transferNoteFormatField:
              if (value == null) {
                isFormValid = false;
              }
            case _sendTransferProofToField:
              if (value == null) {
                isFormValid = false;
              }
          }
        });
      }

      if (!isFormValid) {
        return _showError();
      }

      final eventName = formValues[_eventNameField] as String;
      final eventPickupNote = formValues[_eventPickupNoteField] as String;
      final eventStartAt = formValues[_eventStartAtField] as DateTime;
      final eventEndAt = formValues[_eventEndAtField] as DateTime;
      final orderNumberPrefix = formValues[_orderNumberPrefixField] as String;
      final transferTo = formValues[_transferToField] as String;
      final transferNoteFormat = formValues[_transferNoteFormatField] as String;
      final sendTransferProofTo =
          formValues[_sendTransferProofToField] as String;

      final params = UpdateSettingsParams(
        eventName: eventName,
        eventPickupNote: eventPickupNote,
        eventStartAt: eventStartAt,
        eventEndAt: eventEndAt,
        orderNumberPrefix: orderNumberPrefix,
        transferTo: transferTo,
        transferNoteFormat: transferNoteFormat,
        sendTransferProofTo: sendTransferProofTo,
      );

      context.read<AdminSettingCubit>().updateSetting(params);
    } else {
      return _showError();
    }
  }

  void _showError() {
    context
        .showErrorSnackBar('Pastikan semua kolom sudah terisi dengan benar.');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: theme.primaryColor,
            labelStyle: TextStyle(fontSize: 14.sp),
            unselectedLabelColor: theme.hintColor,
            unselectedLabelStyle: TextStyle(fontSize: 12.sp),
            indicatorColor: Colors.transparent,
            labelPadding: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            tabs: const [
              Tab(text: 'Kegiatan'),
              Tab(text: 'Pesanan'),
              Tab(text: 'Pembayaran'),
            ],
          ),
          BlocListener<AdminSettingCubit, AdminSettingState>(
            listener: (context, state) {
              if (state is UpdateSettingSuccessState) {
                context.showSnackBar('Pengaturan berhasil diperbarui.');
              }

              if (state is UpdateSettingFailureState) {
                context.showErrorSnackBar(state.errorMessage!);
              }
            },
            child: Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          UnderlineTextField(
                            name: _eventNameField,
                            label: 'Nama Kegiatan',
                            hintText: 'Contoh: Bazar Online 2023',
                            initialValue: widget.setting.event.name,
                            maxLength: 50,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(10),
                            ]),
                          ),
                          20.h.height,
                          UnderlineTextField(
                            name: _eventPickupNoteField,
                            label: 'Catatan Pengambilan',
                            hintText: 'Contoh: Ambil di Vihara.',
                            initialValue: widget.setting.event.pickupNote,
                            maxLength: 50,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(10),
                            ]),
                          ),
                          20.h.height,
                          DatePickerField(
                            name: _eventStartAtField,
                            label: 'Tanggal Mulai PO',
                            initialDate: widget.setting.event.startAt,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          20.h.height,
                          DatePickerField(
                            name: _eventEndAtField,
                            label: 'Tanggal Tutup PO',
                            initialDate: widget.setting.event.endAt,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          UnderlineTextField(
                            name: _orderNumberPrefixField,
                            label: 'Prefix ID Pesanan',
                            initialValue:
                                widget.setting.foodOrder.orderNumberPrefix,
                            maxLength: 7,
                            inputFormatters: [AllCapsFormatter()],
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(1),
                              FormValidators.alphanumeric(),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          UnderlineTextField(
                            name: _transferToField,
                            label: 'Transfer ke',
                            hintText: 'Contoh: BCA 8370009211 a.n. YPSBDI',
                            initialValue: widget.setting.payment.transferTo,
                            maxLength: 100,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(10),
                            ]),
                          ),
                          20.h.height,
                          UnderlineTextField(
                            name: _transferNoteFormatField,
                            label: 'Format Berita Transfer',
                            hintText:
                                'Contoh: Bazar_[nama]_[cetya]_[no. pesanan]',
                            initialValue:
                                widget.setting.payment.transferNoteFormat,
                            maxLength: 30,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(10),
                            ]),
                          ),
                          20.h.height,
                          UnderlineTextField(
                            name: _sendTransferProofToField,
                            label: 'Kirim Bukti Transfer ke',
                            hintText: 'Contoh: Admin Bazaar (081234567890)',
                            initialValue:
                                widget.setting.payment.sendTransferProofTo,
                            maxLength: 30,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(10),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: BlocBuilder<AdminSettingCubit, AdminSettingState>(
              builder: (context, state) {
                if (state is UpdateSettingLoadingState) {
                  return const LoadingIndicator();
                }

                return AppElevatedButton(
                  label: 'Simpan',
                  onPressed: _updateSetting,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
