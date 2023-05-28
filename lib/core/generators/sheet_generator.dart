import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:online_bazaar/core/exceptions/app_exception.dart';
import 'package:online_bazaar/core/service_locator/service_locator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;

class SheetGenerator {
  Excel newSheet() => Excel.createExcel();

  Future<void> save(Excel sheet) async {
    try {
      final bytes = sheet.encode();

      if (bytes != null) {
        final datetime = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
        final fileName = 'rekap_pesanan_$datetime.xlsx';

        if (kIsWeb) {
          final content = base64Encode(bytes);
          html.AnchorElement(
            href:
                'data:application/octet-stream;charset=utf-16le;base64,$content',
          )
            ..setAttribute('download', fileName)
            ..click();

          return;
        }

        final directory = await getApplicationDocumentsDirectory();
        final path = directory.path;

        File('$path/$fileName').writeAsBytes(bytes);
      }
    } catch (e, s) {
      logger.error(e, s);
      throw const SheetGeneratorException();
    }
  }
}
