import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/presentation/widgets/menu_item_form.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/top_bar.dart';

enum MenuItemFormType { newItem, editItem }

class MenuItemDialog extends StatelessWidget {
  final MenuItemFormType type;
  final MenuItem? item;

  const MenuItemDialog({
    super.key,
    required this.type,
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    final title = type == MenuItemFormType.newItem ? 'Menu Baru' : 'Ubah Menu';

    if (type == MenuItemFormType.editItem && item == null) {
      return Center(child: appText.body('Menu tidak ditemukan.'));
    }

    return Scaffold(
      appBar: TopBar(title: title),
      body: MenuItemForm(item: item),
    );
  }
}
