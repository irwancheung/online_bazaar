import 'package:online_bazaar/exports.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final Widget? bottomNavigationBar;

  const AppScaffold({
    super.key,
    required this.child,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bottomNavBar = ResponsiveBreakpoints.of(context).screenWidth <=
            maxMobileWidth
        ? bottomNavigationBar
        : bottomNavigationBar != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: maxMobileWidth, child: bottomNavigationBar),
                ],
              )
            : null;
    return Scaffold(
      bottomNavigationBar: bottomNavBar,
      backgroundColor: theme.secondaryHeaderColor,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxMobileWidth),
            child: child,
          ),
        ),
      ),
    );
  }
}
