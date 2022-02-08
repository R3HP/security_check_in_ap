import 'package:flutter/material.dart';
import 'package:security_check_in/model/check_in.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class CheckInDataGridDataSource extends DataGridSource {
  List<DataGridRow> _checkIns = [];

  CheckInDataGridDataSource({required List<CheckIn> checkIns,required BuildContext context}) {
    _checkIns = checkIns
        .map((checkIn) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'timeOut',
                  value:  _setCellTime(checkIn.checkoutDate)
                      // '${checkIn.checkoutDate?.hour ?? '?'} : ${checkIn.checkoutDate?.minute ?? '?'}'
                      ),
              DataGridCell<String>(
                  columnName: 'dateOut',
                  value: checkIn.checkoutDate != null
                      ? Jalali.fromDateTime(checkIn.checkoutDate!)
                          .formatCompactDate()
                      : '?'),
              DataGridCell<String>(
                  columnName: 'timeIn',
                  value: _setCellTime(checkIn.checkInDate)
                  // TimeOfDay(hour: checkIn.checkInDate.hour,minute: checkIn.checkInDate.minute).persianFormat(context)
                      // '${checkIn.checkInDate.hour} : ${checkIn.checkInDate.minute}'
                      ),
              DataGridCell<String>(
                  columnName: 'dateIn',
                  value: Jalali.fromDateTime(checkIn.checkInDate)
                      .formatCompactDate()),
              DataGridCell<String>(
                columnName: 'ship',
                value: checkIn.shipmentIdList!.fold<String>(
                  '',
                  (previousValue, id) =>
                      previousValue +
                      (checkIn.shipmentIdList!.last == id
                          ? id.toString()
                          : '$id - '),
                ),
              ),
              // DataGridCell<List<String>>(columnName: 'ship', value: checkIn.shipmentIdList?.map((e) => e.toString()).expand((element) => [element,'-']).toList()),
              DataGridCell<String>(
                  columnName: 'farahmand',
                  value: checkIn.numberOfFarahmandBaskets?.toString() ?? '?'),
              DataGridCell<String>(
                  columnName: 'prePack',
                  value: checkIn.numberOfPrepackBaskets?.toString() ?? '?'),
              DataGridCell<String>(
                  columnName: 'driverName',
                  value: checkIn.driverName),
              // DataGridCell<int>(columnName: 'id', value: checkIn.id ?? 0),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _checkIns;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row
            .getCells()
            .map(
              (dataGridCell) => Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Text(
                    dataGridCell.value.toString(),
                  ),
                ),
              ),
            )
            .toList());
  }

  String _setCellTime(DateTime? dateTime) {
    StringBuffer stringBuffer = StringBuffer();
    if(dateTime!.hour <= 9 ){
      stringBuffer.write('0${dateTime.hour}');
    }else{
      stringBuffer.write(dateTime.hour);
    }
    stringBuffer.write(':');
    if(dateTime.minute <= 9){
      stringBuffer.write('0${dateTime.minute}');
    }else{
      stringBuffer.write(dateTime.minute);
    }
    return stringBuffer.toString();
  }
}
