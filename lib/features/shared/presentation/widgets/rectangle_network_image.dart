import 'package:cached_network_image/cached_network_image.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/loading_indicator.dart';

class RectangleNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxFit? fit;

  const RectangleNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => const LoadingIndicator(),
      errorWidget: (context, url, error) {
        logger.error('$url\n$error');
        return const Icon(Icons.error);
      },
      imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius!)
            : BorderRadius.zero,
        child: Image(image: imageProvider, fit: fit),
      ),
    );
  }
}
