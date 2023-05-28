import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/core/exceptions/menu_exception.dart';
import 'package:online_bazaar/core/network_info.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_menu_data_source.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_menu_repository.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

class AdminMenuRepositoryImpl implements AdminMenuRepository {
  final NetworkInfo _networkInfo;
  final AdminMenuDataSource _dataSource;

  AdminMenuRepositoryImpl({
    required NetworkInfo networkInfo,
    required AdminMenuDataSource dataSource,
  })  : _networkInfo = networkInfo,
        _dataSource = dataSource;

  @override
  Stream<List<MenuItem>> getMenuItems() {
    return _dataSource.getMenuItems();
  }

  @override
  Future<MenuItem> addMenuItem(AddMenuItemParams params) async {
    try {
      await _networkInfo.checkConnection();

      final uploadedImage = await _dataSource.uploadMenuItemImage(params.image);

      final newParams = params.copyWith(image: uploadedImage);

      return await _dataSource.addMenuItem(newParams);
    } catch (e, s) {
      if (e is AppException) {
        rethrow;
      }

      logger.error(e, s);
      throw const AddMenuItemException();
    }
  }

  @override
  Future<MenuItem> updateMenuItem(UpdateMenuItemParams params) async {
    try {
      await _networkInfo.checkConnection();

      late final String uploadedImage;

      if (!params.image.contains('menu_items')) {
        uploadedImage = await _dataSource.uploadMenuItemImage(params.image);
      } else {
        uploadedImage = params.image;
      }

      final newParams = params.copyWith(image: uploadedImage);

      return await _dataSource.updateMenuItem(newParams);
    } catch (e, s) {
      if (e is AppException) {
        rethrow;
      }

      logger.error(e, s);
      throw const AddMenuItemException();
    }
  }

  @override
  Future<MenuItem> setMenuItemVisibility(
    SetMenuItemVisibilityParams params,
  ) async {
    try {
      await _networkInfo.checkConnection();

      return await _dataSource.setMenuItemVisibility(params);
    } catch (e, s) {
      if (e is AppException) {
        rethrow;
      }

      logger.error(e, s);
      throw const SetMenuItemVisibilityException();
    }
  }
}
