import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/field_label.dart';

class FormDropDown extends StatelessWidget {
  final String name;
  final String? label;
  final String? initialValue;
  final List<DropdownMenuItem> items;
  final Function(dynamic)? onChanged;

  const FormDropDown({
    super.key,
    required this.name,
    this.label,
    this.initialValue,
    required this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) FormFieldLabel(label: label!),
        5.h.height,
        FormBuilderDropdown(
          name: name,
          initialValue: initialValue,
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
