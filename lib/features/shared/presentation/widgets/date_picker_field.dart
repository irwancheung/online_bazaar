import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/field_label.dart';

class DatePickerField extends StatelessWidget {
  final String name;
  final String? label;
  final DateTime? initialDate;
  final String? hintText;
  final String? helperText;
  final String? Function(DateTime?)? validator;

  const DatePickerField({
    super.key,
    required this.name,
    this.label,
    this.initialDate,
    this.hintText,
    this.helperText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final underlineBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: theme.primaryColor),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) FormFieldLabel(label: label!),
        FormBuilderDateTimePicker(
          key: key,
          name: name,
          initialDate: initialDate,
          initialValue: initialDate,
          inputType: InputType.date,
          format: DateFormat('d MMM y'),
          decoration: InputDecoration(
            hintText: hintText,
            helperText: helperText,
            border: underlineBorder,
            focusedBorder: underlineBorder,
            enabledBorder: underlineBorder,
            errorBorder: underlineBorder,
            focusedErrorBorder: underlineBorder,
            disabledBorder: underlineBorder,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
