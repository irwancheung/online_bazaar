import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_setting_cubit.dart';
import 'package:online_bazaar/features/admin/presentation/widgets/setting_form.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_card.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/background_container.dart';

class SettingPageView extends StatefulWidget {
  const SettingPageView({super.key});

  @override
  State<SettingPageView> createState() => _SettingPageViewState();
}

class _SettingPageViewState extends State<SettingPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminSettingCubit>().getSetting();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BackgroundContainer(
      padding: EdgeInsets.all(20.r),
      child: AppCard(
        child: BlocBuilder<AdminSettingCubit, AdminSettingState>(
          builder: (context, state) {
            final setting = state.setting;

            return SettingForm(key: UniqueKey(), setting: setting);
          },
        ),
      ),
    );
  }
}
