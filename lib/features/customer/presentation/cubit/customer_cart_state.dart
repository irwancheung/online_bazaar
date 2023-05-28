part of 'customer_cart_cubit.dart';

class CustomerCartState extends Equatable {
  final Cart cart;
  final String? errorMessage;
  // final DateTime? lastUpdatedAt;

  const CustomerCartState({
    required this.cart,
    this.errorMessage,
    // this.lastUpdatedAt,
  });

  @override
  List<Object?> get props => [cart, errorMessage];

  CustomerCartState copyWith({
    Cart? cart,
    String? errorMessage,
    DateTime? lastUpdatedAt,
  }) {
    return CustomerCartState(
      cart: cart ?? this.cart,
      errorMessage: errorMessage ?? this.errorMessage,
      // lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cart': CartModel.fromEntity(cart).toMap(),
      'errorMessage': errorMessage,
      // 'lastUpdatedAt': lastUpdatedAt?.millisecondsSinceEpoch,
    };
  }

  factory CustomerCartState.fromMap(Map<String, dynamic> map) {
    return CustomerCartState(
      cart: CartModel.fromMap(map['cart'] as Map<String, dynamic>),
      errorMessage: map['errorMessage'] as String?,
      // lastUpdatedAt: map['lastUpdatedAt'] != null
      //     ? DateTime.fromMillisecondsSinceEpoch(map['lastUpdatedAt'] as int)
      //     : null,
    );
  }
}

class SetCartCustomerLoadingState extends CustomerCartState {
  const SetCartCustomerLoadingState({required super.cart});
}

class SetCartCustomerSuccessState extends CustomerCartState {
  const SetCartCustomerSuccessState({required super.cart});
}

class SetCartCustomerFailureState extends CustomerCartState {
  const SetCartCustomerFailureState({
    required super.cart,
    required super.errorMessage,
  });
}

class AddCartItemLoadingState extends CustomerCartState {
  const AddCartItemLoadingState({required super.cart});
}

class AddCartItemSuccessState extends CustomerCartState {
  const AddCartItemSuccessState({required super.cart});
}

class AddCartItemFailureState extends CustomerCartState {
  const AddCartItemFailureState({
    required super.cart,
    required super.errorMessage,
  });
}

class RemoveCartItemLoadingState extends CustomerCartState {
  const RemoveCartItemLoadingState({required super.cart});
}

class RemoveCartItemSuccessState extends CustomerCartState {
  const RemoveCartItemSuccessState({required super.cart});
}

class RemoveCartItemFailureState extends CustomerCartState {
  const RemoveCartItemFailureState({
    required super.cart,
    required super.errorMessage,
  });
}

class UpdateCartItemLoadingState extends CustomerCartState {
  const UpdateCartItemLoadingState({required super.cart});
}

class UpdateCartItemSuccessState extends CustomerCartState {
  const UpdateCartItemSuccessState({required super.cart});
}

class UpdateCartItemFailureState extends CustomerCartState {
  const UpdateCartItemFailureState({
    required super.cart,
    required super.errorMessage,
  });
}

class ValidateCartLoadingState extends CustomerCartState {
  const ValidateCartLoadingState({required super.cart});
}

class ValidateCartSuccessState extends CustomerCartState {
  const ValidateCartSuccessState({required super.cart});
}

class ValidateCartFailureState extends CustomerCartState {
  const ValidateCartFailureState({
    required super.cart,
    required super.errorMessage,
  });
}

class CompleteCheckoutLoadingState extends CustomerCartState {
  const CompleteCheckoutLoadingState({required super.cart});
}

class CompleteCheckoutSuccessState extends CustomerCartState {
  final FoodOrder foodOrder;
  const CompleteCheckoutSuccessState({
    required super.cart,
    required this.foodOrder,
  });
}

class CompleteCheckoutFailureState extends CustomerCartState {
  const CompleteCheckoutFailureState({
    required super.cart,
    required super.errorMessage,
  });
}
