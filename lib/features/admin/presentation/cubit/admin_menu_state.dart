// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'admin_menu_cubit.dart';

class AdminMenuState extends Equatable {
  final List<MenuItem> menuItems;
  final String? errorMessage;

  const AdminMenuState({
    required this.menuItems,
    this.errorMessage,
  });

  AdminMenuState copyWith({
    List<MenuItem>? menuItems,
    String? errorMessage,
  }) {
    return AdminMenuState(
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

  factory AdminMenuState.fromMap(Map<String, dynamic> map) {
    return AdminMenuState(
      menuItems: (map['menuItems'] as List<dynamic>)
          .map((item) => MenuItemModel.fromMap(item as Map<String, dynamic>))
          .toList(),
      errorMessage: map['errorMessage'] as String?,
    );
  }

  @override
  List<Object?> get props => [menuItems, errorMessage];
}

class GetMenuItemsLoadingState extends AdminMenuState {
  const GetMenuItemsLoadingState({required super.menuItems});
}

class GetMenuItemsSuccessState extends AdminMenuState {
  const GetMenuItemsSuccessState({required super.menuItems});
}

class GetMenuItemsFailureState extends AdminMenuState {
  const GetMenuItemsFailureState({
    required super.menuItems,
    required super.errorMessage,
  });
}

class AddMenuItemLoadingState extends AdminMenuState {
  const AddMenuItemLoadingState({required super.menuItems});
}

class AddMenuItemSuccessState extends AdminMenuState {
  final MenuItem menuItem;

  const AddMenuItemSuccessState({
    required this.menuItem,
    required super.menuItems,
  });
}

class AddMenuItemFailureState extends AdminMenuState {
  const AddMenuItemFailureState({
    required super.menuItems,
    required super.errorMessage,
  });
}

class UpdateMenuItemLoadingState extends AdminMenuState {
  const UpdateMenuItemLoadingState({required super.menuItems});
}

class UpdateMenuItemSuccessState extends AdminMenuState {
  final MenuItem menuItem;

  const UpdateMenuItemSuccessState({
    required this.menuItem,
    required super.menuItems,
  });
}

class UpdateMenuItemFailureState extends AdminMenuState {
  const UpdateMenuItemFailureState({
    required super.menuItems,
    required super.errorMessage,
  });
}

class SetMenuItemVisibilityLoadingState extends AdminMenuState {
  const SetMenuItemVisibilityLoadingState({required super.menuItems});
}

class SetMenuItemVisibilitySuccessState extends AdminMenuState {
  final MenuItem menuItem;

  const SetMenuItemVisibilitySuccessState({
    required this.menuItem,
    required super.menuItems,
  });
}

class SetMenuItemVisibilityFailureState extends AdminMenuState {
  const SetMenuItemVisibilityFailureState({
    required super.menuItems,
    required super.errorMessage,
  });
}
