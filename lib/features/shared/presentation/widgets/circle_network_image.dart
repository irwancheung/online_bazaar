import 'package:cached_network_image/cached_network_image.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/loading_indicator.dart';

class CircleNetworkImage extends StatelessWidget {
  final String url;
  final double? radius;
  final bool grayScale;

  const CircleNetworkImage({
    super.key,
    required this.url,
    this.radius,
    this.grayScale = false,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const LoadingIndicator(),
      errorWidget: (context, url, error) {
        logger.error('$url\n$error');
        return const Icon(Icons.error);
      },
      imageBuilder: (context, imageProvider) {
        Widget child = Image(image: imageProvider);

        if (grayScale) {
          child = ColorFiltered(
            colorFilter:
                const ColorFilter.mode(Colors.grey, BlendMode.saturation),
            child: child,
          );
        }

        return CircleAvatar(
          radius: radius,
          child: ClipOval(child: child),
        );
      },
    );
  }
}
