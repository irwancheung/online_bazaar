import 'package:flex_color_scheme/flex_color_scheme.dart';
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
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          height: size.height,
          color: theme.secondaryHeaderColor.darken(5),
          child: Column(
            children: [
              Container(
                height: size.height / 3,
                width: double.infinity,
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
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: const LoginForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
