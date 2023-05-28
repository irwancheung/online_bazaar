import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/admin/data/models/admin_model.dart';
import 'package:online_bazaar/features/admin/domain/entities/admin.dart';

void main() {
  group('AdminModel', () {
    test('should be a subclass of Admin entity.', () {
      // Arrange
      const tAdminModel = AdminModel(
        id: 'id',
        name: 'name',
        email: 'email',
      );

      // assert
      expect(tAdminModel, isA<Admin>());
    });
  });
}
