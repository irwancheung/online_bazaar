import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_auth_cubit.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_menu_cubit.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_card.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_elevated_button.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/background_container.dart';

class LogOutPageView extends StatelessWidget {
  const LogOutPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 150.h),
            child: AppCard(
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    appText.body('Anda yakin ingin keluar?'),
                    20.h.height,
                    BlocConsumer<AdminAuthCubit, AdminAuthState>(
                      listener: (context, state) {
                        if (state is LogoutFailureState) {
                          context.showErrorSnackBar(state.errorMessage!);
                        }

                        if (state is LogoutSuccessState) {
                          context.read<AdminMenuCubit>().cancelSubscription();

                          HydratedBloc.storage.clear();
                          context.pushReplacement(adminLoginPage);
                        }
                      },
                      builder: (context, state) {
                        if (state is LogoutLoadingState) {
                          return const CircularProgressIndicator();
                        }

                        return AppElevatedButton(
                          label: 'Keluar',
                          onPressed: () =>
                              context.read<AdminAuthCubit>().logOut(),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
