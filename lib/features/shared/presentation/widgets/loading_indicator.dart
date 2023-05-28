import 'package:online_bazaar/exports.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 60.r,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
