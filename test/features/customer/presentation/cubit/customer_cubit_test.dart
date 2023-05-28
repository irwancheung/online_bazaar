import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/core/exceptions/customer_exception.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_repository.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_cubit.dart';
import 'package:online_bazaar/features/shared/domain/entities/customer.dart';

import '../../../../helpers.dart';
import 'customer_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CustomerRepository>()])
void main() {
  initHelpersTest();

  late MockCustomerRepository mockRepository;
  late CustomerCubit cubit;

  setUp(() {
    mockRepository = MockCustomerRepository();
    cubit = CustomerCubit(repository: mockRepository);
  });

  group('CustomerCubit', () {
    const tCustomer = Customer(
      id: 'id',
      email: 'email',
      name: 'name',
      chaitya: 'chaitya',
      phone: 'phone',
      address: 'address',
    );

    test('initial state should be CustomerState.', () {
      expect(cubit.state, const CustomerState());
    });

    group('setCustomer()', () {
      const tSetCustomerParams = SetCustomerParams(
        email: 'email',
        name: 'name',
        chaitya: 'chaitya',
        phone: 'phone',
        address: 'address',
      );

      test('should call repository.setCustomer() once.', () async {
        // Assert
        when(mockRepository.setCustomer(any))
            .thenAnswer((_) async => tCustomer);

        // Act
        cubit.setCustomer(tSetCustomerParams);
        await untilCalled(mockRepository.setCustomer(any));

        // Assert
        verify(mockRepository.setCustomer(any)).called(1);
      });

      blocTest<CustomerCubit, CustomerState>(
        'emits [SetCustomerLoadingState, SetCustomerSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.setCustomer(any))
              .thenAnswer((_) async => tCustomer);
        },
        build: () => cubit,
        act: (cubit) => cubit.setCustomer(tSetCustomerParams),
        expect: () => <CustomerState>[
          const SetCustomerLoadingState(customer: null),
          const SetCustomerSuccessState(customer: tCustomer),
        ],
      );

      blocTest<CustomerCubit, CustomerState>(
        'emits [SetCustomerLoadingState, SetCustomerFailureState] when repo is failed.',
        setUp: () {
          when(mockRepository.setCustomer(any))
              .thenThrow(const SetCustomerException(''));
        },
        build: () => cubit,
        act: (cubit) => cubit.setCustomer(tSetCustomerParams),
        expect: () => <CustomerState>[
          const SetCustomerLoadingState(customer: null),
          const SetCustomerFailureState(customer: null, errorMessage: ''),
        ],
      );
    });
  });
}
