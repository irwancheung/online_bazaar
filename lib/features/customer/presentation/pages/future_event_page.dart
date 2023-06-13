import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/shared/domain/entities/event_setting.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_scaffold.dart';

class FutureEventPage extends StatelessWidget {
  final EventSetting event;

  const FutureEventPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final startAt = event.startAt!.dMMMyHHmm;
    final endAt = event.endAt!.dMMMyHHmm;

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
            appText.header(
              event.name,
              fontWeight: FontWeight.bold,
            ),
            20.h.height,
            appText.caption('Mulai PO: $startAt'),
            5.h.height,
            appText.caption('Tutup PO: $endAt')
          ],
        ),
      ),
    );
  }
}
