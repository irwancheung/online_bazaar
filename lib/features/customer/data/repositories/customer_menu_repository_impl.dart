import 'package:online_bazaar/features/customer/data/data_sources/customer_menu_data_source.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_menu_repository.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

class CustomerMenuRepositoryImpl implements CustomerMenuRepository {
  final CustomerMenuDataSource _dataSource;

  const CustomerMenuRepositoryImpl({required CustomerMenuDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Stream<List<MenuItem>> getMenuItems() {
    return _dataSource.getMenuItems();
  }
}
