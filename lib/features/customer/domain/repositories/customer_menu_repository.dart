import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

abstract class CustomerMenuRepository {
  Stream<List<MenuItem>> getMenuItems();
}
