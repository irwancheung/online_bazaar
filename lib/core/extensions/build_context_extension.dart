import 'package:online_bazaar/exports.dart';

extension BuildContextExtension on BuildContext {
  void showBottomSheet(Widget child) {
    showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      builder: (_) => child,
    );
  }

  void showContentDialog(Widget child) {
    showDialog(
      context: this,
      builder: (_) => Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 50.h,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.r),
          child: child,
        ),
      ),
    );
  }

  void showProgressIndicatorDialog() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void showSnackBar(
    String message, {
    Color? textColor,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: appText.caption(
            message,
            color: textColor ?? Theme.of(this).textTheme.bodyLarge!.color,
          ),
          backgroundColor:
              backgroundColor ?? Theme.of(this).colorScheme.secondaryContainer,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 2000),
        ),
      );
  }

  void showErrorSnackBar(String message) {
    showSnackBar(
      message,
      textColor: Theme.of(this).colorScheme.surface,
      backgroundColor: Theme.of(this).colorScheme.error,
    );
  }
}
