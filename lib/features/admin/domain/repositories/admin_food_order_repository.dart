import 'package:equatable/equatable.dart';
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';

abstract class AdminFoodOrderRepository {
  Stream<List<FoodOrder>> getFoodOrders();
  Future<FoodOrder> updateFoodOrderStatus(UpdateFoodOrderStatusParams params);
  Future<FoodOrder> updateAdminNote(UpdateAdminNoteParams params);
  Future<void> exportFoodOrdersToSheetFile(
    ExportFoodOrdersToSheetFileParams params,
  );
}

class UpdateFoodOrderStatusParams extends Equatable {
  final String id;
  final OrderStatus status;

  const UpdateFoodOrderStatusParams({
    required this.id,
    required this.status,
  });

  @override
  List<Object?> get props => [id, status];
}

class UpdateAdminNoteParams extends Equatable {
  final String id;
  final String adminNote;

  const UpdateAdminNoteParams({
    required this.id,
    required this.adminNote,
  });

  @override
  List<Object?> get props => [id, adminNote];
}

class ExportFoodOrdersToSheetFileParams extends Equatable {
  final List<FoodOrder> foodOrders;

  const ExportFoodOrdersToSheetFileParams({
    required this.foodOrders,
  });

  @override
  List<Object?> get props => [foodOrders];
}
