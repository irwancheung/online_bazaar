import 'package:online_bazaar/exports.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const TopBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: title != null
          ? appText.body(
              title!,
              color: theme.primaryColor,
              fontWeight: FontWeight.w600,
            )
          : null,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back_ios_new),
        color: theme.primaryColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
