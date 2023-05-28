part of 'customer_food_order_cubit.dart';

class CustomerFoodOrderState extends Equatable {
  final String? errorMessage;
  const CustomerFoodOrderState({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class DownloadFoorOrderReceiptLoadingState extends CustomerFoodOrderState {
  const DownloadFoorOrderReceiptLoadingState();
}

class DownloadFoorOrderReceiptSuccessState extends CustomerFoodOrderState {
  const DownloadFoorOrderReceiptSuccessState();
}

class DownloadFoorOrderReceiptFailureState extends CustomerFoodOrderState {
  const DownloadFoorOrderReceiptFailureState({required super.errorMessage});
}
