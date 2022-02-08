import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

typedef setCheckInOutTime = void Function(TimeOfDay newTime, bool isCheckIn);
typedef setCheckInOutDate = void Function(Jalali newDate,bool isCheckIn);

class TimeCheckInSection extends StatefulWidget {
  final setCheckInOutDate;
  final setCheckInOutTime;

  final bool isCheckIn;
  Jalali jalaliDate;
  TimeOfDay timeOfDay;
  // final bool isEditing;

  TimeCheckInSection({
    Key? key,
    required this.isCheckIn,
    required this.jalaliDate,
    required this.timeOfDay,
    required this.setCheckInOutDate,
    required this.setCheckInOutTime,
  }) : super(key: key);

  @override
  State<TimeCheckInSection> createState() => _TimeCheckInSectionState();
}

class _TimeCheckInSectionState extends State<TimeCheckInSection> {
  late Jalali jalaliDate;
  late TimeOfDay timeOfDay;

  



  @override
  void initState() {
    super.initState();
    jalaliDate = widget.jalaliDate;
    timeOfDay = widget.timeOfDay;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              children: [
                FittedBox(
                  child: Text(
                    widget.isCheckIn
                        ? 'لطفا تاریخ ورود را انتخاب کنید '
                        : 'لطفا تاریخ خروج را انتخاب کنید ',
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.onPrimary, onPrimary: Theme.of(context).primaryColor),
                  onPressed: () => showPersianDatePicker(
                    context: context,
                    initialDate: jalaliDate,
                    firstDate: Jalali(jalaliDate.year),
                    lastDate: Jalali(jalaliDate.year + 1),
                  ).then((value) {
                    // widget.jalaliDate = value ?? widget.jalaliDate;
                    if (value != null) {
                      widget.setCheckInOutDate(value,widget.isCheckIn);
                      setState(() {
                        jalaliDate = value;
                      });
                    }
                  }),
                  child: FittedBox(
                    child: Text(
                      jalaliDate.formatCompactDate(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const VerticalDivider(
          endIndent: 2,
          indent: 2,
          color: Colors.black,
          width: 40,
          thickness: 2,
        ),
        // if(isEditing)
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              children: [
                FittedBox(
                  child: Text(
                    widget.isCheckIn
                        ? 'لطفا ساعت ورود را انتخاب کنید '
                        : 'لطفا ساعت خروج را مشخص کنید ',
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.onPrimary, onPrimary: Theme.of(context).primaryColor),
                  onPressed: () => showPersianTimePicker(
                    context: context,
                    initialTime: timeOfDay,
                    initialEntryMode: PTimePickerEntryMode.dial,
                  ).then((value) {
                    // widget.timeOfDay = value ?? widget.timeOfDay;
                    if (value != null) {

                      widget.setCheckInOutTime(value,widget.isCheckIn);
                      setState(() {
                        timeOfDay = value;
                      });
                    }
                  }),
                  child: FittedBox(child: Text(timeOfDay.persianFormat(context))),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
