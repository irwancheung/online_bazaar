import 'package:online_bazaar/exports.dart';

class AppElevatedButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;

  const AppElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: appText.body(label),
      ),
    );
  }
}
