import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

import 'package:security_check_in/view/widgets/failure_snackbar.dart';
import 'package:security_check_in/view_model/check_in_view_model.dart';

typedef SetRange = void Function(JalaliRange? jalaliRange);

class PickCheckInRange extends StatefulWidget {
  final SetRange? setRange;

  const PickCheckInRange({
    Key? key,
    this.setRange,
  }) : super(key: key);

  @override
  State<PickCheckInRange> createState() => _PickCheckInRangeState();
}

class _PickCheckInRangeState extends State<PickCheckInRange> {
  JalaliRange? selectedRange;

  @override
  Widget build(BuildContext context) {
    final checkInViewModel =
        Provider.of<CheckInViewModel>(context, listen: false);
    return selectedRange != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('از' +
                  selectedRange!.start.formatCompactDate() +
                  'الی ' +
                  selectedRange!.end.formatCompactDate()),
              IconButton(
                onPressed: () {
                  checkInViewModel.clearSearchCheckIns();
                  setState(() {
                    selectedRange = null;
                    if (widget.setRange != null) {
                      widget.setRange!(null);
                    }
                  });
                },
                icon: const Icon(
                  Icons.cancel_rounded,
                  color: Colors.redAccent,
                ),
              ),
            ],
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                onPrimary: Theme.of(context).colorScheme.onSecondary),
            onPressed: () {
              showPersianDateRangePicker(
                      initialEntryMode: PDatePickerEntryMode.input,
                      context: context,
                      firstDate: Jalali(Jalali.now().year),
                      lastDate: Jalali.now())
                  .then((jalaliRange) {
                if (jalaliRange != null) {
                  checkInViewModel.getRangedCheckIns(jalaliRange);
                  setState(() {
                    selectedRange = jalaliRange;
                    if (widget.setRange != null) {
                      widget.setRange!(jalaliRange);
                    }
                  });
                } else {
                  checkInViewModel.clearSearchCheckIns();
                }
              })
                  // .then((value) => ScaffoldMessenger.of(context).showSnackBar(SuccessSnackBar()))
                  .catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(FailureSnackBar(
                  message: error.toString(),
                ));
              });
            },
            child: const Text('بازه زمانی خود را انتخاب کنید '),
          );
  }
}
