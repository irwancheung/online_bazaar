part of 'admin_food_order_cubit.dart';

class AdminFoodOrderState extends Equatable {
  final List<FoodOrder> foodOrders;
  final String? errorMessage;

  const AdminFoodOrderState({
    required this.foodOrders,
    this.errorMessage,
  });

  AdminFoodOrderState copyWith({
    List<FoodOrder>? foodOrders,
    String? errorMessage,
  }) {
    return AdminFoodOrderState(
      foodOrders: foodOrders ?? this.foodOrders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'foodOrders': foodOrders
          .map((order) => FoodOrderModel.fromEntity(order).toMap())
          .toList(),
      'errorMessage': errorMessage,
    };
  }

  factory AdminFoodOrderState.fromMap(Map<String, dynamic> map) {
    return AdminFoodOrderState(
      foodOrders: (map['foodOrders'] as List<dynamic>)
          .map(
            (item) => FoodOrderModel.fromMap(item as Map<String, dynamic>),
          )
          .toList(),
      errorMessage: map['errorMessage'] as String?,
    );
  }

  @override
  List<Object?> get props => [foodOrders, errorMessage];
}

class GetFoodOrdersLoadingState extends AdminFoodOrderState {
  const GetFoodOrdersLoadingState({required super.foodOrders});
}

class GetFoodOrdersSuccessState extends AdminFoodOrderState {
  const GetFoodOrdersSuccessState({required super.foodOrders});
}

class GetFoodOrdersFailureState extends AdminFoodOrderState {
  const GetFoodOrdersFailureState({
    required super.foodOrders,
    required super.errorMessage,
  });
}

class UpdateFoodOrderStatusLoadingState extends AdminFoodOrderState {
  const UpdateFoodOrderStatusLoadingState({required super.foodOrders});
}

class UpdateFoodOrderStatusSuccessState extends AdminFoodOrderState {
  final FoodOrder foodOrder;

  const UpdateFoodOrderStatusSuccessState({
    required this.foodOrder,
    required super.foodOrders,
  });
}

class UpdateFoodOrderStatusFailureState extends AdminFoodOrderState {
  const UpdateFoodOrderStatusFailureState({
    required super.foodOrders,
    required super.errorMessage,
  });
}

class UpdateAdminNoteLoadingState extends AdminFoodOrderState {
  const UpdateAdminNoteLoadingState({required super.foodOrders});
}

class UpdateAdminNoteSuccessState extends AdminFoodOrderState {
  final FoodOrder foodOrder;

  const UpdateAdminNoteSuccessState({
    required this.foodOrder,
    required super.foodOrders,
  });
}

class UpdateAdminNoteFailureState extends AdminFoodOrderState {
  const UpdateAdminNoteFailureState({
    required super.foodOrders,
    required super.errorMessage,
  });
}

class ExportFoodOrdersToSheetFileLoadingState extends AdminFoodOrderState {
  const ExportFoodOrdersToSheetFileLoadingState({required super.foodOrders});
}

class ExportFoodOrdersToSheetFileSuccessState extends AdminFoodOrderState {
  const ExportFoodOrdersToSheetFileSuccessState({required super.foodOrders});
}

class ExportFoodOrdersToSheetFileFailureState extends AdminFoodOrderState {
  const ExportFoodOrdersToSheetFileFailureState({
    required super.foodOrders,
    required super.errorMessage,
  });
}
