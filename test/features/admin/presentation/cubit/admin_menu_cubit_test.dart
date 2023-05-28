import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_bazaar/core/exceptions/menu_exception.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_menu_repository.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_menu_cubit.dart';
import 'package:online_bazaar/features/shared/domain/entities/menu_item.dart';

import '../../../../helpers.dart';
import 'admin_menu_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdminMenuRepository>()])
void main() {
  initHelpersTest();

  late MockAdminMenuRepository mockRepository;
  late AdminMenuCubit cubit;

  setUp(() {
    mockRepository = MockAdminMenuRepository();
    cubit = AdminMenuCubit(repository: mockRepository);
  });

  group('AdminMenuCubit', () {
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

    test('initial state should be AdminMenuState.', () {
      expect(cubit.state, const AdminMenuState(menuItems: []));
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

      blocTest<AdminMenuCubit, AdminMenuState>(
        'emits [GetMenuItemsLoadingState, GetMenuItemsSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.getMenuItems())
              .thenAnswer((_) => Stream.value(tItems));
        },
        build: () => cubit,
        act: (cubit) => cubit.getMenuItems(),
        expect: () => <AdminMenuState>[
          const GetMenuItemsLoadingState(menuItems: []),
          GetMenuItemsSuccessState(menuItems: tItems),
        ],
      );
    });

    group('addMenuItem()', () {
      const tParams = AddMenuItemParams(
        name: 'name',
        image: 'image',
        variants: [],
        sellingPrice: 0,
        remainingQuantity: 0,
      );

      test('should call repository.addMenuItem() once.', () async {
        // Assert
        when(mockRepository.addMenuItem(any)).thenAnswer((_) async => tItem);

        // Act
        cubit.addMenuItem(tParams);
        await untilCalled(mockRepository.addMenuItem(tParams));

        // Assert
        verify(mockRepository.addMenuItem(tParams)).called(1);
      });

      blocTest<AdminMenuCubit, AdminMenuState>(
        'emits [AddMenuItemLoadingState, AddMenuItemSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.addMenuItem(any)).thenAnswer((_) async => tItem);
        },
        build: () => cubit,
        act: (cubit) => cubit.addMenuItem(tParams),
        expect: () => <AdminMenuState>[
          const AddMenuItemLoadingState(menuItems: []),
          const AddMenuItemSuccessState(menuItem: tItem, menuItems: []),
        ],
      );

      blocTest<AdminMenuCubit, AdminMenuState>(
        'emits [AddMenuItemLoadingState, AddMenuItemFailureState] when repo is failed.',
        setUp: () {
          when(mockRepository.addMenuItem(any))
              .thenThrow(const AddMenuItemException(''));
        },
        build: () => cubit,
        act: (cubit) => cubit.addMenuItem(tParams),
        expect: () => <AdminMenuState>[
          const AddMenuItemLoadingState(menuItems: []),
          const AddMenuItemFailureState(menuItems: [], errorMessage: ''),
        ],
      );
    });

    group('updateMenuItem()', () {
      const tParams = UpdateMenuItemParams(
        id: 'id',
        name: 'name',
        image: 'image',
        variants: [],
        sellingPrice: 0,
        remainingQuantity: 0,
      );

      test('should call repository.updateMenuItem() once.', () async {
        // Assert
        when(mockRepository.updateMenuItem(any)).thenAnswer((_) async => tItem);

        // Act
        cubit.updateMenuItem(tParams);
        await untilCalled(mockRepository.updateMenuItem(tParams));

        // Assert
        verify(mockRepository.updateMenuItem(tParams)).called(1);
      });

      blocTest<AdminMenuCubit, AdminMenuState>(
        'emits [UpdateMenuItemLoadingState, UpdateMenuItemSuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.updateMenuItem(any))
              .thenAnswer((_) async => tItem);
        },
        build: () => cubit,
        act: (cubit) => cubit.updateMenuItem(tParams),
        expect: () => <AdminMenuState>[
          const UpdateMenuItemLoadingState(menuItems: []),
          const UpdateMenuItemSuccessState(menuItem: tItem, menuItems: []),
        ],
      );

      blocTest<AdminMenuCubit, AdminMenuState>(
        'emits [UpdateMenuItemLoadingState, UpdateMenuItemFailureState] when repo is failed.',
        setUp: () {
          when(mockRepository.updateMenuItem(any))
              .thenThrow(const UpdateMenuItemException(''));
        },
        build: () => cubit,
        act: (cubit) => cubit.updateMenuItem(tParams),
        expect: () => <AdminMenuState>[
          const UpdateMenuItemLoadingState(menuItems: []),
          const UpdateMenuItemFailureState(menuItems: [], errorMessage: ''),
        ],
      );
    });

    group('setMenuItemVisibility()', () {
      const tParams = SetMenuItemVisibilityParams(id: 'id', isVisible: true);

      test('should call repository.setMenuItemVisibility() once.', () async {
        // Assert
        when(mockRepository.setMenuItemVisibility(any))
            .thenAnswer((_) async => tItem);

        // Act
        cubit.setMenuItemVisibility(tParams);
        await untilCalled(mockRepository.setMenuItemVisibility(tParams));

        // Assert
        verify(mockRepository.setMenuItemVisibility(tParams)).called(1);
      });

      blocTest<AdminMenuCubit, AdminMenuState>(
        'emits [SetMenuItemVisibilityLoadingState, SetMenuItemVisibilitySuccessState] when repo is successful.',
        setUp: () {
          when(mockRepository.setMenuItemVisibility(any))
              .thenAnswer((_) async => tItem);
        },
        build: () => cubit,
        act: (cubit) => cubit.setMenuItemVisibility(tParams),
        expect: () => <AdminMenuState>[
          const SetMenuItemVisibilityLoadingState(menuItems: []),
          const SetMenuItemVisibilitySuccessState(
            menuItem: tItem,
            menuItems: [],
          ),
        ],
      );

      blocTest<AdminMenuCubit, AdminMenuState>(
        'emits [SetMenuItemVisibilityLoadingState, SetMenuItemVisibilityFailureState] when repo is failed.',
        setUp: () {
          when(mockRepository.setMenuItemVisibility(any))
              .thenThrow(const SetMenuItemVisibilityException(''));
        },
        build: () => cubit,
        act: (cubit) => cubit.setMenuItemVisibility(tParams),
        expect: () => <AdminMenuState>[
          const SetMenuItemVisibilityLoadingState(menuItems: []),
          const SetMenuItemVisibilityFailureState(
            menuItems: [],
            errorMessage: '',
          ),
        ],
      );
    });
  });
}
