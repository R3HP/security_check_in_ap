import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:security_check_in/repository/check_in_data_grid_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MySfGrid extends StatelessWidget {
  const MySfGrid({
    Key? key,
    required this.gridKey,
    required this.selectedRange,
    required this.checkInDataGridDataSource,
  }) : super(key: key);

  final GlobalKey<SfDataGridState> gridKey;
  final JalaliRange? selectedRange;
  final CheckInDataGridDataSource? checkInDataGridDataSource;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SfDataGrid(
        key: gridKey,
        columnWidthMode: ColumnWidthMode.auto,
        gridLinesVisibility: GridLinesVisibility.both,
        stackedHeaderRows: [
          StackedHeaderRow(cells: [
            StackedHeaderCell(
                // text: ,
                columnNames: [
                  // 'id',
                  'driverName',
                  'prePack',
                  'farahmand',
                  'ship',
                  'dateIn',
                  'timeIn',
                  'dateOut',
                  'timeOut'
                ],
                child: Center(
                  child: Text(
                    selectedRange!.start
                                .compareTo(selectedRange!.end) ==
                            0
                        ? 'لیست ورود خروج شرکت در تاریخ ${selectedRange!.start.formatCompactDate()}'
                        : 'لیست ورود خروج شرکت از تاریخ ${selectedRange!.start.formatCompactDate()} الی ${selectedRange!.end.formatCompactDate()}',
                  ),
                ))
          ])
        ],
        source: checkInDataGridDataSource!,
        columns: <GridColumn>[
          GridColumn(
              maximumWidth: 65,
              columnName: 'timeOut',
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const FittedBox(child: Text('ساعت خروج')),
              )),
          GridColumn(
              minimumWidth: 90,
              maximumWidth: 95,
              columnName: 'dateOut',
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const FittedBox(child: Text('تاریخ خروج')),
              )),
          GridColumn(
              maximumWidth: 65,
              columnName: 'timeIn',
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const FittedBox(child: Text('ساعت ورود')),
              )),
          GridColumn(
              minimumWidth: 90,
              maximumWidth: 95,
              columnName: 'dateIn',
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const FittedBox(child: Text('تاریخ ورود')),
              )),
          GridColumn(
              minimumWidth: 130,
              maximumWidth: 180,
              columnName: 'ship',
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child:
                    const FittedBox(child: Text('شماره حواله')),
              )),
          GridColumn(
              maximumWidth: 75,
              columnName: 'farahmand',
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const FittedBox(
                    child: Text('سبد های فرهمند')),
              )),
          GridColumn(
              maximumWidth: 75,
              columnName: 'prePack',
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const FittedBox(
                    child: Text('سبد های پری پک')),
              )),
          GridColumn(
              minimumWidth: 150,
              maximumWidth: 150,
              columnName: 'driverName',
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const FittedBox(
                    child: Text('نام و نام خانوادگی عامل')),
              )),
        ],
      ),
    );
  }
}
