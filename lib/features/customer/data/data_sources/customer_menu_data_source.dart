import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_bazaar/features/shared/data/models/menu_item_model.dart';

class CustomerMenuDataSource {
  final FirebaseFirestore _firestore;

  const CustomerMenuDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<List<MenuItemModel>> getMenuItems() {
    return _itemsRef
        .where('isVisible', isEqualTo: true)
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MenuItemModel.fromMap(doc.data()))
          .toList();
    });
  }

  CollectionReference<Map<String, dynamic>> get _itemsRef =>
      _firestore.collection('menu_items');
}
