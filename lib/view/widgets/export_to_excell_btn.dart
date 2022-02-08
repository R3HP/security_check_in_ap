import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:security_check_in/model/util.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import 'package:security_check_in/model/excel_converter.dart';

class ExportToExcellButton extends StatelessWidget {
  final GlobalKey<SfDataGridState> gridKey;
  final JalaliRange selectedRange;

  final String? driverName;

  const ExportToExcellButton({
    Key? key,
    required this.gridKey,
    required this.selectedRange,
    this.driverName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        
      ),

        onPressed: () {
          exportToExcell().then((filepath) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                filepath,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            return filepath;
          }).then((filePath) => OpenFile.open(filePath));
        },
        child: const Text('EXCEL'));
  }

  Future<String> exportToExcell() async {
    // final dir = await syspath.getExternalStorageDirectory();

    // var dirPath = dir!.path;
    // dirPath = dirPath.replaceAll(
    //     'Android/data/com.logicDev.security_checkIn/files', '');
    // dirPath = '${dirPath}CheckIn';
    // final directory = await Directory(dirPath).create(recursive: true);
    final String filePath;

    final downloadDir = Directory('/storage/emulated/0/Download');
    final downloadDirCheckInDir =
        await Directory(downloadDir.path + '/CheckIn').create(recursive: true);

    final workbook = gridKey.currentState!.exportToExcelWorkbook(
      converter: MyExcelConverter(),
      exportStackedHeaders: false,
      excludeColumns: ['id'],
      exportColumnWidth: true,
      cellExport: (details) {
        if (details.cellType == DataGridExportCellType.columnHeader) {
          details.excelRange
              .setValue(setCelValue(details.cellValue.toString()));
        }
        details.excelRange.cellStyle.hAlign = HAlignType.center;
        details.excelRange.cellStyle.vAlign = VAlignType.center;
      },
    );
    final List<int> bytes = workbook.saveAsStream();
    if (driverName == null) {
      final file = await File(downloadDirCheckInDir.path +
              '/${selectedRange.start.formatCompactDate().replaceAll('/', ',')}_${selectedRange.end.formatCompactDate().replaceAll('/', ',')}.xlsx')
          .writeAsBytes(bytes);
      filePath = file.path;
    } else {
      final file = await File(downloadDirCheckInDir.path +
              '/${driverName!}_${selectedRange.start.formatCompactDate().replaceAll('/', ',')}_${selectedRange.end.formatCompactDate().replaceAll('/', ',')}.xlsx')
          .writeAsBytes(bytes);
      filePath = file.path;
    }
    workbook.dispose();
    return filePath;
  }
}
