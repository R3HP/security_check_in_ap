import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:security_check_in/view/widgets/check_in_grid.dart';
import 'package:security_check_in/view/widgets/pick_check_in_range.dart';

import 'package:security_check_in/model/check_in.dart';
import 'package:security_check_in/view/widgets/check_in_list_item.dart';
import 'package:security_check_in/view_model/check_in_view_model.dart';

class ExportScreen extends StatefulWidget {
  static const routeName = '/export_screen';

  const ExportScreen({Key? key}) : super(key: key);

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  List<CheckIn>? mycheckIns;
  late final String? driverName;
  JalaliRange? selectedRange;
  late final CheckInViewModel checkInViewModel;
  bool isFirst = true;
  

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirst) {
      checkInViewModel = Provider.of<CheckInViewModel>(context);
      var args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      selectedRange = args?['selectedRange'];
      driverName = args?['driverName'];
      isFirst = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    checkInViewModel.clearSearchCheckIns();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  void setRange(JalaliRange? jalaliRange) {
    selectedRange = jalaliRange;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(mycheckIns == null
        ? [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
        : [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('خروجی'),
      ),
      body: mycheckIns == null
          ? Column(
              children: [
                PickCheckInRange(
                  setRange: setRange,
                ),
                if (checkInViewModel.checkIns != null)
                  if (checkInViewModel.checkIns!.isNotEmpty)
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          mycheckIns = checkInViewModel.checkIns;
                        });
                      },
                      icon: const Icon(Icons.exit_to_app_sharp),
                      label: const Text('خروجی بگیر'),
                    ),
                Expanded(
                  child: checkInViewModel.checkIns == null
                      ? const Center(
                          child: Text('موردی یافت نشد'),
                        )
                      : ListView.builder(
                          itemCount: checkInViewModel.checkIns!.length,
                          itemBuilder: (ctx, index) => CheckInListItem(
                              checkIn: checkInViewModel.checkIns![index]),
                        ),
                ),
              ],
            )
          : CheckInGrid(selectedRange: selectedRange,myCheckIns: mycheckIns!, driverName: driverName),
    );
  }
}

