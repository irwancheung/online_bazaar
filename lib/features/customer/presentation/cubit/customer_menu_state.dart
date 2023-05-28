part of 'customer_menu_cubit.dart';

class CustomerMenuState extends Equatable {
  final List<MenuItem> menuItems;
  final String? errorMessage;

  const CustomerMenuState({
    required this.menuItems,
    this.errorMessage,
  });

  CustomerMenuState copyWith({
    List<MenuItem>? menuItems,
    String? errorMessage,
  }) {
    return CustomerMenuState(
      menuItems: menuItems ?? this.menuItems,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'menuItems': menuItems
          .map((item) => MenuItemModel.fromEntity(item).toMap())
          .toList(),
      'errorMessage': errorMessage,
    };
  }

  factory CustomerMenuState.fromMap(Map<String, dynamic> map) {
    return CustomerMenuState(
      menuItems: (map['menuItems'] as List<dynamic>)
          .map((item) => MenuItemModel.fromMap(item as Map<String, dynamic>))
          .toList(),
      errorMessage: map['errorMessage'] as String?,
    );
  }

  @override
  List<Object?> get props => [menuItems, errorMessage];
}

class GetMenuItemsLoadingState extends CustomerMenuState {
  const GetMenuItemsLoadingState({required super.menuItems});
}

class GetMenuItemsSuccessState extends CustomerMenuState {
  const GetMenuItemsSuccessState({required super.menuItems});
}

class GetMenuItemsFailureState extends CustomerMenuState {
  const GetMenuItemsFailureState({
    required super.menuItems,
    required super.errorMessage,
  });
}
