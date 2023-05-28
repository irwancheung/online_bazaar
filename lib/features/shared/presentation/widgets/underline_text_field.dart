import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/field_label.dart';

class UnderlineTextField extends StatelessWidget {
  final String name;
  final String? label;
  final String? initialValue;
  final String? hintText;
  final String? helperText;
  final int? helperMaxLines;
  final int minLines;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool enabled;
  final TextAlign textAlign;
  final String? Function(String?)? validator;

  const UnderlineTextField({
    super.key,
    required this.name,
    this.label,
    this.initialValue,
    this.hintText,
    this.helperText,
    this.helperMaxLines,
    this.minLines = 1,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.textAlign = TextAlign.start,
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
        FormBuilderTextField(
          key: key,
          name: name,
          initialValue: initialValue,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          minLines: !obscureText ? minLines : 1,
          maxLines: !obscureText ? maxLines : 1,
          autocorrect: false,
          textAlign: textAlign,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hintText,
            helperText: helperText,
            helperMaxLines: helperMaxLines,
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
