part of 'customer_cubit.dart';

class CustomerState extends Equatable {
  final Customer? customer;
  final String? errorMessage;
  const CustomerState({
    this.customer,
    this.errorMessage,
  });

  CustomerState copyWith({
    Customer? customer,
    String? errorMessage,
  }) {
    return CustomerState(
      customer: customer ?? this.customer,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customer':
          customer != null ? CustomerModel.fromEntity(customer!).toMap() : null,
      'errorMessage': errorMessage,
    };
  }

  factory CustomerState.fromMap(Map<String, dynamic> map) {
    return CustomerState(
      customer: map['customer'] != null
          ? CustomerModel.fromMap(map['customer'] as Map<String, dynamic>)
          : null,
      errorMessage: map['errorMessage'] as String?,
    );
  }

  @override
  List<Object?> get props => [customer, errorMessage];
}

class SetCustomerLoadingState extends CustomerState {
  const SetCustomerLoadingState({required super.customer});
}

class SetCustomerSuccessState extends CustomerState {
  const SetCustomerSuccessState({required super.customer});
}

class SetCustomerFailureState extends CustomerState {
  const SetCustomerFailureState({
    required super.customer,
    required super.errorMessage,
  });
}
