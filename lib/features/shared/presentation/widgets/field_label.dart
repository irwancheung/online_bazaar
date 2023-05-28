import 'package:online_bazaar/exports.dart';

class FormFieldLabel extends StatelessWidget {
  final String label;

  const FormFieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return appText.caption(label, fontWeight: FontWeight.w600);
  }
}
