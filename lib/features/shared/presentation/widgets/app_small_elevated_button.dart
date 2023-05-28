import 'package:online_bazaar/exports.dart';

class AppSmallElevatedButton extends StatelessWidget {
  final String label;
  final bool isCancel;
  final Function()? onPressed;

  const AppSmallElevatedButton({
    super.key,
    required this.label,
    this.isCancel = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 40.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isCancel ? theme.colorScheme.error : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: appText.caption(label),
      ),
    );
  }
}
