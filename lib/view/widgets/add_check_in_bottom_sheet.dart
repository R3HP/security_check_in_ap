import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

import 'package:security_check_in/model/check_in.dart';
import 'package:security_check_in/model/driver.dart';
import 'package:security_check_in/view/widgets/baskets_section.dart';
import 'package:security_check_in/view/widgets/driver_drop_down.dart';
import 'package:security_check_in/view/widgets/my_divider.dart';
import 'package:security_check_in/view/widgets/shipments_id_text_field.dart';
import 'package:security_check_in/view/widgets/success_snackbar.dart';
import 'package:security_check_in/view/widgets/time_check_in_section.dart';
import 'package:security_check_in/view_model/check_in_view_model.dart';
import 'package:security_check_in/view_model/driver_view_model.dart';

class AddCheckInBottomSheet extends StatefulWidget {
  final bool isEditing;
  final CheckIn? checkIn;

  const AddCheckInBottomSheet({
    Key? key,
    required this.isEditing,
    this.checkIn,
  }) : super(key: key);

  @override
  State<AddCheckInBottomSheet> createState() => _AddCheckInBottomSheetState();
}

class _AddCheckInBottomSheetState extends State<AddCheckInBottomSheet> {
  GlobalKey<FormState> shimpemtFormKey = GlobalKey<FormState>();
  late final DriverViewModel driverViewModel;
  late final CheckInViewModel checkInViewModel;
  String? selectedDriver;

  late Jalali checkInDate;
  late TimeOfDay checkInTime;
  late Jalali? checkOutDate;
  late TimeOfDay? checkOutTime;
  late final TextEditingController _farahmandController;
  late final TextEditingController _prepackController;
  late List<int> shipmentList;

  List<Driver>? driverList;

  @override
  void initState() {
    super.initState();
    driverViewModel = Provider.of<DriverViewModel>(context, listen: false);
    checkInViewModel = Provider.of<CheckInViewModel>(context, listen: false);
    selectedDriver = widget.checkIn?.driverName;
    checkInDate = widget.checkIn != null
        ? Jalali.fromDateTime(widget.checkIn!.checkInDate)
        : Jalali.now();

    checkInTime = widget.checkIn != null
        ? TimeOfDay(
            hour: widget.checkIn!.checkInDate.hour,
            minute: widget.checkIn!.checkInDate.minute)
        : TimeOfDay.now();

    checkOutDate = widget.checkIn == null
        ? null
        : widget.checkIn!.checkoutDate != null
            ? Jalali.fromDateTime(widget.checkIn!.checkoutDate!)
            : Jalali.now();

    checkOutTime = widget.checkIn == null
        ? null
        : widget.checkIn!.checkoutDate != null
            ? TimeOfDay(
                hour: widget.checkIn!.checkoutDate!.hour,
                minute: widget.checkIn!.checkoutDate!.minute)
            : TimeOfDay.now();

    _farahmandController = TextEditingController(
        text: widget.checkIn?.numberOfFarahmandBaskets.toString());

    _prepackController = TextEditingController(
        text: widget.checkIn?.numberOfPrepackBaskets.toString());

    shipmentList = widget.checkIn?.shipmentIdList ?? [];

    driverViewModel.getAllDrivers().then((value) => setState(() {
          driverList = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return driverList == null
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.9,
            minChildSize: 0.7,
            maxChildSize: 1,
            builder: (context, scrollController) => ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(8.0),
              children: [
                const FittedBox(
                    child: Text('لطفا راننده مورد نظر را انتخاب کنید ')),
                Align(
                  alignment: Alignment.centerLeft,
                  child: MyStatefulDropDown(
                      selectedDriver: selectedDriver,
                      driversList: driverList!,
                      setDriver: (selected) => selectedDriver = selected),
                ),
                const MyDivider(),
                TimeCheckInSection(
                  isCheckIn: true,
                  jalaliDate: checkInDate,
                  timeOfDay: checkInTime,
                  setCheckInOutDate: setCheckInOutDate,
                  setCheckInOutTime: setCheckInOutTime,
                ),
                const MyDivider(),
                BasketsSection(
                    prepackController: _prepackController,
                    farahmandController: _farahmandController),
                const MyDivider(),
                Row(
                  children: [
                    const Expanded(
                      child: FittedBox(
                          child:
                              Text('شماره حواله های مورد نظر را وارد کنید ')),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ShipmentsIdTextField(
                          shipmentIds: shipmentList,
                          shipmentFormKey: shimpemtFormKey,
                        ),
                      ),
                    )
                  ],
                ),
                const MyDivider(),
                if (widget.checkIn != null)
                  TimeCheckInSection(
                    isCheckIn: false,
                    jalaliDate: checkOutDate!,
                    timeOfDay: checkOutTime!,
                    setCheckInOutDate: setCheckInOutDate,
                    setCheckInOutTime: setCheckInOutTime,
                  ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: submitCheckIn,
                  child: const FittedBox(
                    child: Text(
                      'ثبت',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8.0),
                      elevation: 25.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      fixedSize: const Size(double.infinity, 50)),
                )
              ],
            ),
          );
  }

  void submitCheckIn() {
    DateTime? checkOutDateWithTime;
    if (shimpemtFormKey.currentState!.validate()) {
      shimpemtFormKey.currentState!.save();
    }
    final checkInDateTime = checkInDate.toDateTime();
    final checkInDateWithTime = DateTime(
        checkInDateTime.year,
        checkInDateTime.month,
        checkInDateTime.day,
        checkInTime.hour,
        checkInTime.minute);
    if (widget.checkIn != null) {
      final checkOutDateTime = checkOutDate!.toDateTime();
      checkOutDateWithTime = DateTime(
        checkOutDateTime.year,
        checkOutDateTime.month,
        checkOutDateTime.day,
        checkOutTime!.hour,
        checkOutTime!.minute,
      );
    }
    final checkin = CheckIn(
      driverName: selectedDriver!,
      checkInDate: checkInDateWithTime,
      checkoutDate: checkOutDateWithTime,
      shipmentIdList: shipmentList,
      numberOfFarahmandBaskets: int.parse(
          _farahmandController.text.isEmpty ? '0' : _farahmandController.text),
      numberOfPrepackBaskets: int.parse(
          _prepackController.text.isEmpty ? '0' : _prepackController.text),
    );
    if (widget.checkIn == null) {
      checkInViewModel
          .addNewCheckIn(checkin)
          .then((value) => SuccessSnackBar())
          .then((value) => Navigator.of(context).pop());
    } else {
      checkInViewModel
          .updateCheckIn(checkin, widget.checkIn!.id!)
          .then((value) => SuccessSnackBar())
          .then((value) => Navigator.of(context).pop());
    }
  }

  void setCheckInOutDate(Jalali newDate, bool isCheckIn) {
    if (isCheckIn) {
      checkInDate = newDate;
    } else {
      checkOutDate = newDate;
    }
  }

  void setCheckInOutTime(TimeOfDay newTime, bool isCheckIn) {
    if (isCheckIn) {
      checkInTime = newTime;
    } else {
      checkOutTime = newTime;
    }
  }
}
