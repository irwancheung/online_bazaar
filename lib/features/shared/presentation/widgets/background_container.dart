import 'package:online_bazaar/exports.dart';

class BackgroundContainer extends StatelessWidget {
  final EdgeInsets? padding;
  final Widget? child;

  const BackgroundContainer({
    super.key,
    this.padding,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.focusColor.withOpacity(0.1),
      alignment: Alignment.center,
      padding: padding,
      child: child,
    );
  }
}
