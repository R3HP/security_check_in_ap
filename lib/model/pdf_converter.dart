
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class MyPdfConverter extends DataGridToPdfConverter{

  // @override
  // PdfDocument exportToPdfDocument
  @override
  PdfDocument exportToPdfDocument(
      SfDataGrid dataGrid, List<DataGridRow>? rows) {
    final PdfDocument pdfDocument = PdfDocument();
    pdfDocument.pageSettings.orientation = PdfPageOrientation.landscape;



    //adding page into pdf document
    final PdfPage pdfPage = pdfDocument.pages.add();
    
    

    _exportHeaderFooter(pdfPage, pdfDocument.template);

    //export pdf grid into pdf document
    final PdfGrid pdfGrid = exportToPdfGrid(dataGrid, rows);

    // for (var i = 0; i < pdfGrid.columns.count; i++) {
    //   final col = pdfGrid.columns[i];
    //   col.
    // }

    // super.columns.forEach((element) {element = 25})

    //Draw the pdf grid into pdf document
    pdfGrid.draw(page: pdfPage, bounds: Rect.zero);

    return pdfDocument;
  }
  

  void _exportHeaderFooter(
      PdfPage pdfPage, PdfDocumentTemplate pdfDocumentTemplate) {
    if (headerFooterExport != null) {
      final DataGridPdfHeaderFooterExportDetails details =
          DataGridPdfHeaderFooterExportDetails(pdfPage, pdfDocumentTemplate);
      headerFooterExport!(details);
    }
  }

  
  // void _exportCellToPdf(
  //   DataGridExportCellType cellType,
  //   PdfGridCell pdfCell,
  //   Object? cellValue,
  //   GridColumn column,
  // ) {
    
  //   if (cellExport != null) {
  //     final DataGridCellPdfExportDetails details = DataGridCellPdfExportDetails(
  //         cellType, pdfCell, cellValue, column.columnName);
  //     cellExport!(details);
  //   }
  // }



  
  // /// Exports a column header to Pdf
  // @protected
  // void exportColumnHeader(SfDataGrid dataGrid, GridColumn column,
  //     String columnName, PdfGrid pdfGrid) {
  //   int rowSpan = 0;
  //   PdfGridRow columnHeader = pdfGrid.headers[rowIndex];
  //   PdfGridCell pdfCell = columnHeader.cells[_columnIndex];

  //   if (dataGrid.stackedHeaderRows.isNotEmpty && exportStackedHeaders) {
  //     rowSpan = getRowSpan(
  //         dataGrid: dataGrid,
  //         isStackedHeader: false,
  //         columnName: columnName,
  //         rowIndex: rowIndex - 1,
  //         columnIndex: dataGrid.columns.indexOf(column));
  //   }
  //   if (rowSpan > 0) {
  //     columnHeader = pdfGrid.headers[rowIndex - 1];
  //     pdfCell = columnHeader.cells[_columnIndex];
  //     pdfCell.rowSpan = rowSpan + 1;
  //     pdfCell.value = columnName;
  //   } else {
  //     pdfCell.value = columnName;
  //   }
  //   pdfCell.style.borders.all = _pdfPen;
  //   _exportCellToPdf(
  //       DataGridExportCellType.columnHeader, pdfCell, columnName, column);
  // }

  // @override
  // void _exportCellToPdf(
  //   DataGridExportCellType cellType,
  //   PdfGridCell pdfCell,
  //   Object? cellValue,
  //   GridColumn column,
  // ) {
  //   pdfCell.value
  //   if (cellExport != null) {
  //     final DataGridCellPdfExportDetails details = DataGridCellPdfExportDetails(
  //         cellType, pdfCell, cellValue, column.columnName);
  //     cellExport!(details);
  //   }
  // }

  
  
}