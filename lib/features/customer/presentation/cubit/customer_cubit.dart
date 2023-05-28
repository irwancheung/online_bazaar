import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_repository.dart';
import 'package:online_bazaar/features/shared/data/models/customer_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';

part 'customer_state.dart';

class CustomerCubit extends HydratedCubit<CustomerState> {
  final CustomerRepository _repository;

  CustomerCubit({required CustomerRepository repository})
      : _repository = repository,
        super(const CustomerState());

  Future<void> setCustomer(SetCustomerParams params) async {
    try {
      emit(const SetCustomerLoadingState(customer: null));

      final customer = await _repository.setCustomer(params);

      emit(SetCustomerSuccessState(customer: customer));
    } on AppException catch (e) {
      emit(
        SetCustomerFailureState(
          customer: state.customer,
          errorMessage: e.message,
        ),
      );
    }
  }

  @override
  CustomerState? fromJson(Map<String, dynamic> json) {
    try {
      return CustomerState.fromMap(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(CustomerState state) {
    try {
      return state.toMap();
    } catch (_) {
      return null;
    }
  }
}
