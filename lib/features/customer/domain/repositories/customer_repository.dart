import 'package:equatable/equatable.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';

abstract class CustomerRepository {
  Future<Customer> setCustomer(SetCustomerParams params);
}

class SetCustomerParams extends Equatable {
  final String email;
  final String name;
  final String chaitya;
  final String phone;
  final String address;

  const SetCustomerParams({
    required this.email,
    required this.name,
    required this.chaitya,
    required this.phone,
    required this.address,
  });

  @override
  List<Object?> get props => [
        email,
        name,
        chaitya,
        phone,
        address,
      ];
}
