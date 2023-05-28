import 'package:online_bazaar/core/exceptions/customer_exception.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_repository.dart';
import 'package:online_bazaar/features/shared/data/models/customer_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  @override
  Future<Customer> setCustomer(SetCustomerParams params) async {
    try {
      return CustomerModel.fromSetCustomerParams(params);
    } catch (e, s) {
      logger.error(e, s);

      throw const SetCustomerException();
    }
  }
}
