import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:security_check_in/model/check_in.dart';
import 'package:security_check_in/repository/check_in_data_grid_data_source.dart';
import 'package:security_check_in/view/widgets/export_to_excell_btn.dart';
import 'package:security_check_in/view/widgets/export_to_pdf_btn.dart';
import 'package:security_check_in/view/widgets/my_sf_grid.dart';

class CheckInGrid extends StatelessWidget {
  CheckInGrid({
    Key? key,
    required this.selectedRange,
    this.driverName,
    required this.myCheckIns,
  }) : super(key: key);

  final gridKey = GlobalKey<SfDataGridState>();
  final JalaliRange? selectedRange;
  final String? driverName;
  final List<CheckIn> myCheckIns;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: MySfGrid(
                gridKey: gridKey,
                selectedRange: selectedRange,
                checkInDataGridDataSource: CheckInDataGridDataSource(checkIns: myCheckIns, context: context)),
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: ExportToPdfButton(
                      driverName: driverName,
                      gridKey: gridKey,
                      selectedRange: selectedRange!)),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                  child: ExportToExcellButton(
                      driverName: driverName,
                      gridKey: gridKey,
                      selectedRange: selectedRange!)),
              const SizedBox(
                width: 20,
              )
            ],
          )
        ],
      );
  }
}
