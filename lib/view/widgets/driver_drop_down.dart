import 'package:flutter/material.dart';
import 'package:security_check_in/model/driver.dart';

class MyStatefulDropDown extends StatefulWidget {
  final List<Driver> driversList;
  final Function setDriver;
  final String? selectedDriver;

  const MyStatefulDropDown({
    Key? key,
    required this.driversList,
    required this.setDriver,
    this.selectedDriver,
  }) : super(key: key);

  @override
  State<MyStatefulDropDown> createState() => _MyStatefulDropDownState();
}

class _MyStatefulDropDownState extends State<MyStatefulDropDown> {
  String? dropDownDriver;

  @override
  void initState() {
    super.initState();
    dropDownDriver = widget.selectedDriver;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        elevation: 8,
        hint: const ClipRRect(
          borderRadius: BorderRadius.all(Radius.elliptical(5, 10)),
          child: Text('راننده مورد نظرتو انتخاب کن !'),
        ),
        value: dropDownDriver,
        items: widget.driversList
            .map((driver) => DropdownMenuItem<String>(
                  child: Text(driver.name),
                  value: driver.name,
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            dropDownDriver = value;
            widget.setDriver(value);
          });
        });
  }
}
