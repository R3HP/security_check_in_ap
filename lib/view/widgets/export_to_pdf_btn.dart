import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';

import 'package:security_check_in/model/pdf_converter.dart';
import 'package:security_check_in/model/util.dart';

class ExportToPdfButton extends StatelessWidget {
  final GlobalKey<SfDataGridState> gridKey;
  final JalaliRange selectedRange;

  final String? driverName;

  const ExportToPdfButton({
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
        )
      ),
        onPressed: () {
          exportToPdf().then((filePath) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                filePath,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            return filePath;
          }).then((filePath) => OpenFile.open(filePath));
        },
        child: const Text('PDF'));
  }

  Future<String> exportToPdf() async {
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

    final fontData = await rootBundle.load('assets/fonts/Byekan.ttf');
    final fontBytes = fontData.buffer
        .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    final PdfDocument document = gridKey.currentState!.exportToPdfDocument(
      cellExport: (details) {
        if (details.cellType == DataGridExportCellType.columnHeader) {
          details.pdfCell.style.cellPadding = PdfPaddings(top: 10, bottom: 10);
          details.pdfCell.value =
              setCelValue(details.cellValue.toString().trim());
          details.pdfCell.style.font = PdfTrueTypeFont(
            fontBytes,
            12,
          );
          debugPrint(
              'header cell value : ${details.cellValue.toString()} , header cell column name : ${details.columnName}, header cell hieght : ${details.pdfCell.height}');
        } else {
          details.pdfCell.style.font = PdfTrueTypeFont(
            fontBytes,
            8,
          );
          // print(
          //     'not header cell value : ${details.cellValue.toString()} ,not header cell column name : ${details.columnName}, header cell hieght : ${details.pdfCell.height}');

          details.pdfCell.style.cellPadding = PdfPaddings(top: 5, bottom: 5);
        }
        details.pdfCell.stringFormat = PdfStringFormat(
          wordWrap: PdfWordWrapType.character,
          alignment: PdfTextAlignment.center,
          textDirection:
              details.columnName == 'timeIn' || details.columnName == 'timeOut'
                  ? PdfTextDirection.leftToRight
                  : PdfTextDirection.rightToLeft,
        );
      },
      fitAllColumnsInOnePage: false,
      converter: MyPdfConverter(),
      autoColumnWidth: true,
      excludeColumns: ['id'],
      exportStackedHeaders: false,
      canRepeatHeaders: true,
      headerFooterExport: (details) {
        details.pdfDocumentTemplate.oddTop = PdfPageTemplateElement(
            Rect.fromCenter(
                center: const Offset(1000, 0), width: 800, height: 50))
          ..graphics.drawString(
            driverName != null
                ? selectedRange.start.compareTo(selectedRange.end) == 0
                    ? '$driverName \n لیست ورود خروج شرکت در تاریخ ${selectedRange.start.formatCompactDate()}'
                    : '$driverName \n لیست ورود خروج شرکت از تاریخ ${selectedRange.start.formatCompactDate()} الی ${selectedRange.end.formatCompactDate()}'
                : selectedRange.start.compareTo(selectedRange.end) == 0
                    ? 'لیست ورود خروج شرکت در تاریخ ${selectedRange.start.formatCompactDate()}'
                    : 'لیست ورود خروج شرکت از تاریخ ${selectedRange.start.formatCompactDate()} الی ${selectedRange.end.formatCompactDate()}',
            PdfTrueTypeFont(fontBytes, 8),
            format: PdfStringFormat(
              alignment: PdfTextAlignment.left,
              textDirection: PdfTextDirection.rightToLeft,
            ),
          );
      },
    );
    final List<int> bytes = document.save();
    if (driverName == null) {
      final file = await File(downloadDirCheckInDir.path +
              '/${selectedRange.start.formatCompactDate().replaceAll('/', ',')}_${selectedRange.end.formatCompactDate().replaceAll('/', ',')}.pdf')
          .writeAsBytes(bytes);
      filePath = file.path;
    } else {
      final file = await File(downloadDirCheckInDir.path +
              '/${driverName!}_${selectedRange.start.formatCompactDate().replaceAll('/', ',')}_${selectedRange.end.formatCompactDate().replaceAll('/', ',')}.pdf')
          .writeAsBytes(bytes);
      filePath = file.path;
    }
    document.dispose();
    return filePath;
  }
}
