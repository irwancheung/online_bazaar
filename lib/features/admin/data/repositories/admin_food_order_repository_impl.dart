import 'package:excel/excel.dart' as xcl;
import 'package:online_bazaar/core/enums/food_order_enum.dart';
import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/core/exceptions/food_order_exception.dart';
import 'package:online_bazaar/core/generators/sheet_generator.dart';
import 'package:online_bazaar/core/network_info.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/data/data_sources/admin_food_order_data_source.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_food_order_repository.dart';
import 'package:online_bazaar/features/shared/data/models/food_order_model.dart';

class AdminFoodOrderRepositoryImpl implements AdminFoodOrderRepository {
  final NetworkInfo _networkInfo;
  final SheetGenerator _sheetGenerator;
  final AdminFoodOrderDataSource _dataSource;

  AdminFoodOrderRepositoryImpl({
    required NetworkInfo networkInfo,
    required SheetGenerator sheetGenerator,
    required AdminFoodOrderDataSource dataSource,
  })  : _networkInfo = networkInfo,
        _sheetGenerator = sheetGenerator,
        _dataSource = dataSource;

  @override
  Stream<List<FoodOrderModel>> getFoodOrders() {
    return _dataSource.getFoodOrders();
  }

  @override
  Future<FoodOrderModel> updateFoodOrderStatus(
    UpdateFoodOrderStatusParams params,
  ) async {
    try {
      await _networkInfo.checkConnection();

      return await _dataSource.updateFoodOrderStatus(params);
    } catch (e, s) {
      if (e is AppException) {
        rethrow;
      }

      logger.error(e, s);
      throw const UpdateFoodOrderStatusException();
    }
  }

  @override
  Future<void> exportFoodOrdersToSheetFile(
    ExportFoodOrdersToSheetFileParams params,
  ) async {
    try {
      //TODO: need refactor
      const ordersSummary = 'Ringkasan Pesanan';
      const ordersDetail = 'Rincian Pesanan';

      final sheetFile = _sheetGenerator.newSheet();
      sheetFile.rename('Sheet1', ordersSummary);
      sheetFile.setDefaultSheet(ordersSummary);

      final ordersSummarySheet = sheetFile[ordersSummary];
      final ordersSummaryCols = [
        'Kode Pesanan',
        'Tanggal',
        'Status',
        'Nama',
        'Cetya',
        'No HP',
        'Jenis Pengiriman',
        'Alamat Pengiriman',
        'Catatan',
        'Jumlah Item',
        'Total'
      ];
      ordersSummarySheet.appendRow(ordersSummaryCols);

      final ordersDetailSheet = sheetFile[ordersDetail];
      final ordersDetailCols = [
        'Kode Pesanan',
        'Nama Item',
        'Varian',
        'Jumlah',
        'Harga',
      ];
      ordersDetailSheet.appendRow(ordersDetailCols);

      for (var i = 0; i < ordersSummaryCols.length; i++) {
        ordersSummarySheet.setColAutoFit(i);
        ordersDetailSheet.setColAutoFit(i);

        final cellStyle = xcl.CellStyle(
          bold: true,
          horizontalAlign: xcl.HorizontalAlign.Center,
          verticalAlign: xcl.VerticalAlign.Center,
          leftBorder: xcl.Border(borderStyle: xcl.BorderStyle.Thin),
          rightBorder: xcl.Border(borderStyle: xcl.BorderStyle.Thin),
          topBorder: xcl.Border(borderStyle: xcl.BorderStyle.Thin),
          bottomBorder: xcl.Border(borderStyle: xcl.BorderStyle.Thin),
        );

        final colCode = 'A'.toAscii();
        ordersSummarySheet
            .cell(xcl.CellIndex.indexByString('${(colCode + i).toChar()}1'))
            .cellStyle = cellStyle;

        ordersDetailSheet
            .cell(xcl.CellIndex.indexByString('${(colCode + i).toChar()}1'))
            .cellStyle = cellStyle;
      }

      int ordersSummaryRowIndex = 2;
      int ordersDetailRowIndex = 2;

      for (final order in params.foodOrders) {
        final deliveryAddress = order.deliveryAddress;
        final deliverTo = deliveryAddress != null
            ? '${deliveryAddress.name}\n${deliveryAddress.phone}\n${deliveryAddress.address}'
            : '';

        ordersSummarySheet.appendRow([
          order.orderNumber,
          order.createdAt!.dMMMy,
          order.statusText,
          order.customer.name,
          order.customer.chaitya,
          order.customer.phone,
          if (order.type == OrderType.delivery)
            'Antar ke alamat'
          else
            'Ambil di tempat',
          deliverTo,
          order.note,
          order.totalQuantity,
          order.totalPrice.toCurrencyFormat(),
        ]);

        for (var i = 0; i < ordersSummaryCols.length; i++) {
          ordersSummarySheet
              .cell(
                xcl.CellIndex.indexByString(
                  '${('A'.toAscii() + i).toChar()}$ordersSummaryRowIndex',
                ),
              )
              .cellStyle = xcl.CellStyle(
            horizontalAlign:
                i != 9 ? xcl.HorizontalAlign.Left : xcl.HorizontalAlign.Right,
            verticalAlign: xcl.VerticalAlign.Top,
            leftBorder: xcl.Border(borderStyle: xcl.BorderStyle.Thin),
            rightBorder: xcl.Border(borderStyle: xcl.BorderStyle.Thin),
            topBorder: xcl.Border(borderStyle: xcl.BorderStyle.Thin),
            bottomBorder: xcl.Border(borderStyle: xcl.BorderStyle.Thin),
          );
        }

        ordersSummaryRowIndex++;

        for (final items in order.items) {
          ordersDetailSheet.appendRow([
            order.orderNumber,
            items.name,
            items.variant,
            items.quantity,
            items.price.toCurrencyFormat(),
          ]);

          for (var i = 0; i < 5; i++) {
            ordersDetailSheet
                .cell(
                  xcl.CellIndex.indexByString(
                    '${('A'.toAscii() + i).toChar()}$ordersDetailRowIndex',
                  ),
                )
                .cellStyle = xcl.CellStyle(
              horizontalAlign:
                  i != 4 ? xcl.HorizontalAlign.Left : xcl.HorizontalAlign.Right,
              verticalAlign: xcl.VerticalAlign.Top,
              leftBorder: xcl.Border(borderStyle: xcl.BorderStyle.Thin),
              rightBorder: xcl.Border(borderStyle: xcl.BorderStyle.Thin),
              topBorder: xcl.Border(borderStyle: xcl.BorderStyle.Thin),
              bottomBorder: xcl.Border(borderStyle: xcl.BorderStyle.Thin),
            );
          }

          ordersDetailRowIndex++;
        }
      }

      await _sheetGenerator.save(sheetFile);
    } on AppException {
      rethrow;
    } catch (e, s) {
      logger.error(e, s);
      throw const ExportFoodOrdersToSheetFileException();
    }
  }
}
