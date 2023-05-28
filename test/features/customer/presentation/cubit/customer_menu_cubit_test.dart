import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_menu_repository.dart';
import 'package:online_bazaar/features/customer/presentation/cubit/customer_menu_cubit.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

import '../../../../helpers.dart';
import 'customer_menu_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CustomerMenuRepository>()])
void main() {
  initHelpersTest();

  late MockCustomerMenuRepository mockRepository;
  late CustomerMenuCubit cubit;

  setUp(() {
    mockRepository = MockCustomerMenuRepository();
    cubit = CustomerMenuCubit(repository: mockRepository);
  });

  group('CustomerMenuCubit', () {
    const tItem = MenuItem(
      id: 'id',
      name: 'name',
      image: 'image',
      variants: [],
      sellingPrice: 0,
      soldQuantity: 0,
      remainingQuantity: 0,
      isVisible: true,
    );

    final tItems = [tItem];

    test('initial state should be CustomerMenuState.', () {
      expect(cubit.state, const CustomerMenuState(menuItems: []));
    });

    group('getMenuItems()', () {
      test('should call repository.getMenuItems() once.', () async {
        // Assert
        when(mockRepository.getMenuItems())
            .thenAnswer((_) => Stream.value(tItems));

        // Act
        cubit.getMenuItems();
        await untilCalled(mockRepository.getMenuItems());

        // Assert
        verify(mockRepository.getMenuItems()).called(1);
      });

      blocTest<CustomerMenuCubit, CustomerMenuState>(
        'emits [GetMenuItemsLoadingState, GetMenuItemsSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.getMenuItems())
              .thenAnswer((_) => Stream.value(tItems));
        },
        build: () => cubit,
        act: (cubit) => cubit.getMenuItems(),
        expect: () => <CustomerMenuState>[
          const GetMenuItemsLoadingState(menuItems: []),
          GetMenuItemsSuccessState(menuItems: tItems),
        ],
      );
    });
  });
}
