import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:security_check_in/model/driver.dart';
import 'package:security_check_in/view/screens/driver_details_screen.dart';
import 'package:security_check_in/view/widgets/car_lisence_plate_widget.dart';
import 'package:security_check_in/view_model/driver_view_model.dart';

class DriverListItem extends StatelessWidget {
  final Driver driver;

  const DriverListItem({
    Key? key,
    required this.driver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(driver.name),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) => showConfirmDeleteDialog(context),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle
          ),
          clipBehavior: Clip.antiAlias,
          child: Hero(

            tag: driver.name,
            child: Container(
              
              decoration: const BoxDecoration(),
              clipBehavior: Clip.hardEdge,
              child: FadeInImage(
                
                imageErrorBuilder: (context, error, stackTrace) => Image.asset('assets/images/user_2.png'),
                placeholder: const AssetImage('assets/images/user_2.png'),
                image: FileImage(
                  File(driver.imagePath),
                ),
              ),
            ),
          ),
        ),
        title: Text(driver.name),
        subtitle: Row(
          children: [
            CarLicensePlate(
              width: 110,
              height: 50,
              carId: driver.carId,
            )
          ],
        ),
        trailing: Column(
          children: [const Icon(Icons.local_shipping), Text(driver.car)],
        ),
        onTap: () => Navigator.of(context).pushNamed(
            DriverDetailsScreen.routeName,
            arguments: {'driver': driver}),
      ),
    );
  }

  showConfirmDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('آیا مطمئن هستید '),
        actions: [
          ElevatedButton(
              onPressed: () {
                Provider.of<DriverViewModel>(context, listen: false)
                    .deleteDriver(driver.id!)
                    .then((value) => Navigator.of(context).pop());
              },
              child: const Text('حذف')),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('بازگشت'),
            style: ElevatedButton.styleFrom(primary: Colors.transparent,elevation: 0,onPrimary: Colors.indigoAccent,side: const BorderSide(color: Colors.indigoAccent)),
          ),
        ],
      ),
    );
  }
}
