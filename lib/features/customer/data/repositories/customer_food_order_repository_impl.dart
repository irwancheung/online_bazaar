import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:online_bazaar/core/exceptions/food_order_exception.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/customer/domain/repositories/customer_food_order_repository.dart';
import 'package:online_bazaar/features/customer/presentation/widgets/food_order_receipt.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:universal_html/html.dart' as html;

class CustomerFoodOrderRepositoryImpl implements CustomerFoodOrderRepository {
  final ScreenshotController _screenshotController;

  const CustomerFoodOrderRepositoryImpl({
    required ScreenshotController screenshotController,
  }) : _screenshotController = screenshotController;

  @override
  Future<void> downloadFoodOrderReceipt(
    DownloadFoodOrderReceiptParams params,
  ) async {
    try {
      logger.debug('Downloading food order receipt');

      final image = await _screenshotController.captureFromWidget(
        FoodOrderReceipt(foodOrder: params.foodOrder),
      );

      final fileName = 'struk_bazar_online_${params.foodOrder.orderNumber}.png';

      if (kIsWeb) {
        final content = base64Encode(image);
        html.AnchorElement(
          href:
              'data:application/octet-stream;charset=utf-16le;base64,$content',
        )
          ..setAttribute('download', fileName)
          ..click();
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final path = directory.path;
        final file = File('$path/$fileName');
        await file.writeAsBytes(image);
      }
    } catch (e, s) {
      logger.error(e, s);
      throw const DownloadFoodOrderReceiptException();
    }
  }
}
