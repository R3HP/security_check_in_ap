import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class MyExcelConverter extends DataGridToExcelConverter{

  // Exports the [SfDataGrid] to Excel [Workbook].
  @override
  Workbook exportToExcelWorkbook(SfDataGrid dataGrid, List<DataGridRow>? rows) {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    // print('1 :-sheet colums ${sheet.columns.innerList}');
    exportToExcelWorksheet(dataGrid, rows, sheet);
    // print('1 :-sheet colums ${sheet.columns.innerList}');
    for ( final col in sheet.columns.innerList){
      if(col != null){
      sheet.autoFitColumn(col.index);
      }
    }
    return workbook;
  }

  
}