import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/presentation/widgets/customer_profile_form.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_card.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/background_container.dart';

class CustomerProfilePageView extends StatefulWidget {
  const CustomerProfilePageView({super.key});

  @override
  State<CustomerProfilePageView> createState() =>
      _CustomerProfilePageViewState();
}

class _CustomerProfilePageViewState extends State<CustomerProfilePageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BackgroundContainer(
      padding: EdgeInsets.all(20.r),
      child: AppCard(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: const CustomerProfileForm(),
        ),
      ),
    );
  }
}
