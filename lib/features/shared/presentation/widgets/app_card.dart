import 'package:online_bazaar/exports.dart';

class AppCard extends StatelessWidget {
  final EdgeInsets? margin;
  final double borderRadius;
  final Widget child;

  const AppCard({
    super.key,
    this.margin,
    this.borderRadius = 30,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 10,
      margin: margin,
      shadowColor: theme.shadowColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
