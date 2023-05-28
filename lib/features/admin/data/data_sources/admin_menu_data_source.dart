import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/core/exceptions/menu_exception.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_menu_repository.dart';
import 'package:online_bazaar/features/shared/data/models/menu_item_model.dart';

class AdminMenuDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  const AdminMenuDataSource({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _firestore = firestore,
        _storage = storage;

  Stream<List<MenuItemModel>> getMenuItems() {
    return _itemsRef.orderBy('name').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => MenuItemModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Future<MenuItemModel> addMenuItem(AddMenuItemParams params) async {
    try {
      final now = DateTime.now();

      final newItem = MenuItemModel(
        id: now.millisecondsSinceEpoch.toString(),
        name: params.name,
        image: params.image,
        variants: params.variants,
        sellingPrice: params.sellingPrice,
        soldQuantity: 0,
        remainingQuantity: params.remainingQuantity,
        isVisible: true,
        createdAt: now,
      );

      final docRef = await _itemsRef.add(newItem.toMap());
      final id = docRef.id;

      await _itemsRef.doc(id).update({'id': id});
      final itemSnapshot = await _itemsRef.doc(id).get();

      return MenuItemModel.fromMap(itemSnapshot.data()!);
    } catch (e, s) {
      logger.error(e, s);
      throw const AddMenuItemException();
    }
  }

  Future<MenuItemModel> updateMenuItem(UpdateMenuItemParams params) async {
    try {
      await _firestore.runTransaction(
        (transaction) async {
          final currentItemRef = _itemsRef.doc(params.id);
          final currentItemDoc = await transaction.get(currentItemRef);

          if (!currentItemDoc.exists) {
            throw const UpdateMenuItemException('Item tidak ditemukan.');
          }

          transaction.update(
            currentItemRef,
            {
              'name': params.name,
              'image': params.image,
              'variants': params.variants,
              'sellingPrice': params.sellingPrice,
              'remainingQuantity': params.remainingQuantity,
              'updatedAt': DateTime.now().millisecondsSinceEpoch,
            },
          );
        },
      );

      final itemSnapshot = await _itemsRef.doc(params.id).get();
      return MenuItemModel.fromMap(itemSnapshot.data()!);
    } on AppException {
      rethrow;
    } catch (e, s) {
      logger.error(e, s);
      throw const UpdateMenuItemException();
    }
  }

  Future<MenuItemModel> setMenuItemVisibility(
    SetMenuItemVisibilityParams params,
  ) async {
    try {
      await _firestore.runTransaction(
        (transaction) async {
          final currentItemRef = _itemsRef.doc(params.id);
          final currentItemDoc = await transaction.get(currentItemRef);

          if (!currentItemDoc.exists) {
            throw const SetMenuItemVisibilityException('Item tidak ditemukan.');
          }

          transaction.update(currentItemRef, {
            'isVisible': params.isVisible,
            'updatedAt': DateTime.now().millisecondsSinceEpoch,
          });
        },
      );

      final itemSnapshot = await _itemsRef.doc(params.id).get();
      return MenuItemModel.fromMap(itemSnapshot.data()!);
    } catch (e, s) {
      logger.error(e, s);
      throw const SetMenuItemVisibilityException();
    }
  }

  Future<String> uploadMenuItemImage(String filePath) async {
    try {
      final name = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = _storageRef.child('menu_items/$name.jpg');
      final metadata = SettableMetadata(contentType: 'image/jpeg');

      late TaskSnapshot snapshot;
      if (kIsWeb) {
        final bytes = await http.readBytes(Uri.parse(filePath));
        snapshot = await ref.putData(bytes, metadata);
      } else {
        snapshot = await ref.putFile(File(filePath), metadata);
      }

      return snapshot.ref.getDownloadURL();
    } catch (e, s) {
      logger.error(e, s);
      throw const UploadMenuItemImageException();
    }
  }

  CollectionReference<Map<String, dynamic>> get _itemsRef =>
      _firestore.collection('menu_items');

  Reference get _storageRef => _storage.ref();
}
