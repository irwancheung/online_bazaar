import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_food_order_repository.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_food_order_cubit.dart';
import 'package:online_bazaar/features/admin/presentation/widgets/food_order_card.dart';
import 'package:online_bazaar/features/shared/domain/entities/food_order.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/background_container.dart';

class FoodOrderPageView extends StatefulWidget {
  const FoodOrderPageView({super.key});

  @override
  State<FoodOrderPageView> createState() => _FoodOrderPageViewState();
}

class _FoodOrderPageViewState extends State<FoodOrderPageView>
    with AutomaticKeepAliveClientMixin {
  List<FoodOrder> _foodOrders = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminFoodOrderCubit>().getFoodOrders();
    });
  }

  void _exportToSheet() {
    context.read<AdminFoodOrderCubit>().exportFoodOrdersToSheetFile(
          ExportFoodOrdersToSheetFileParams(foodOrders: _foodOrders),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BackgroundContainer(
      child: BlocConsumer<AdminFoodOrderCubit, AdminFoodOrderState>(
        listener: (context, state) {
          if (state is ExportFoodOrdersToSheetFileLoadingState) {
            context.showProgressIndicatorDialog();
          }

          if (state is ExportFoodOrdersToSheetFileFailureState) {
            context.pop();
            context.showErrorSnackBar(state.errorMessage!);
          }

          if (state is ExportFoodOrdersToSheetFileSuccessState) {
            context.pop();
            context.showSnackBar('Berhasil ekspor data ke Excel.');
          }
        },
        builder: (context, state) {
          if (state is GetFoodOrdersLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetFoodOrdersFailureState) {
            return Center(child: appText.body(state.errorMessage!));
          }

          if (state is GetFoodOrdersSuccessState) {
            _foodOrders = state.foodOrders;
          }

          if (_foodOrders.isNotEmpty) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: _foodOrders.length,
                  padding: EdgeInsets.fromLTRB(20.r, 20.r, 20.r, 70.r),
                  itemBuilder: (context, index) {
                    return FoodOrderCard(foodOrder: _foodOrders[index]);
                  },
                ),
                Positioned(
                  bottom: 20.r,
                  right: 20.r,
                  child: FloatingActionButton(
                    onPressed: _exportToSheet,
                    child: const FaIcon(FontAwesomeIcons.solidFileExcel),
                  ),
                ),
              ],
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/no_food_order.png', height: 100.r),
              10.h.height,
              appText.body(
                'Belum ada pesanan.',
                fontWeight: FontWeight.w600,
              ),
            ],
          );
        },
      ),
    );
  }
}
