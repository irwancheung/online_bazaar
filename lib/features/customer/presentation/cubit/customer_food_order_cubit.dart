import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_food_order_repository.dart';

part 'customer_food_order_state.dart';

class CustomerFoodOrderCubit extends Cubit<CustomerFoodOrderState> {
  final CustomerFoodOrderRepository _repository;

  CustomerFoodOrderCubit({required CustomerFoodOrderRepository repository})
      : _repository = repository,
        super(const CustomerFoodOrderState());

  Future<void> downloadFoodOrderReceipt(
    DownloadFoodOrderReceiptParams params,
  ) async {
    try {
      emit(const DownloadFoorOrderReceiptLoadingState());

      await _repository.downloadFoodOrderReceipt(params);

      emit(const DownloadFoorOrderReceiptSuccessState());
    } on AppException catch (e) {
      emit(DownloadFoorOrderReceiptFailureState(errorMessage: e.message));
    }
  }
}
