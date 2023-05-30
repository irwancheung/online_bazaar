import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/presentation/widgets/login_form.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_scaffold.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return AppScaffold(
      child: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: theme.focusColor,
            child: Column(
              children: [
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: 50.h,
                      horizontal: 20.w,
                    ),
                    child: const LoginForm(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size.height / 3,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 20.h),
            decoration: BoxDecoration(
              color: theme.canvasColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.r),
                bottomRight: Radius.circular(50.r),
              ),
            ),
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  'assets/icons/app_logo.png',
                  height: 100.r,
                  width: 100.r,
                ),
                50.h.height,
                appText.header('Admin Login'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
