import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_scaffold.dart';

class NoEventPage extends StatelessWidget {
  const NoEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 100.r,
              child: Image.asset('assets/icons/app_logo.png'),
            ),
            20.h.height,
            appText.body(
              'Tidak ada kegiatan bazar saat ini.',
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
