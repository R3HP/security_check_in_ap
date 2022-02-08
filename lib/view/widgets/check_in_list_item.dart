import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'package:security_check_in/model/check_in.dart';
import 'package:security_check_in/view/screens/check_in_detail_screen.dart';

class CheckInListItem extends StatelessWidget {
  final CheckIn checkIn;
  DateTime? checkOuTDateTime;
  Jalali? checkOutJalali;

  CheckInListItem({
    Key? key,
    required this.checkIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkInDateTime = checkIn.checkInDate;
    final checkInJalali = Jalali.fromDateTime(checkInDateTime)
        .add(hours: checkInDateTime.hour, minutes: checkInDateTime.minute);

    if (checkIn.checkoutDate != null) {
      checkOuTDateTime = checkIn.checkoutDate;
      checkOutJalali = Jalali.fromDateTime(checkOuTDateTime!).add(
          hours: checkOuTDateTime!.hour, minutes: checkOuTDateTime!.minute);
    }
    return Card(
      elevation: 15,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
          bottom: Radius.circular(10.0),
        ),
      ),
      child: ListTile(
        
        onTap: () => Navigator.of(context).pushNamed(CheckDetailScreen.routeName,arguments: {'check_in' : checkIn}),
        title: Text(checkIn.driverName),
        isThreeLine: true,
        leading: SizedBox(
          width: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                  child: Row(
                children: [
                  const FittedBox(
                    child: Text('فرهمند :'),
                  ),
                  FittedBox(
                    child: Text(checkIn.numberOfFarahmandBaskets.toString()),
                  )
                ],
              )),
              FittedBox(
                  child: Row(
                children: [
                  const FittedBox(
                    child: Text('پری پک :'),
                  ),
                  FittedBox(
                    child: Text(checkIn.numberOfPrepackBaskets.toString()),
                  )
                ],
              )),
            ],
          ),
        ),
        trailing: Container(
          // height:  checkIn.shipmentIdList!.length * 20 + 20  , 
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Theme.of(context).colorScheme.secondary
          ),
          alignment: Alignment.center,
          child: ListView(

            children:
                checkIn.shipmentIdList!.map((e) => Align(alignment: Alignment.topCenter,child: Text(e.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),))).toList(),
          ),
        ),
        subtitle: FittedBox(
          child: Text(
            checkIn.checkoutDate != null
                ? 'ورود : ' +checkInJalali.formatCompactDate() +
                    '\t | \t' +
                    TimeOfDay.fromDateTime(checkInDateTime)
                        .persianFormat(context)+
                    '\n'+
                    'خروج : ' +checkOutJalali!.formatCompactDate() +
                    '\t | \t' +
                    TimeOfDay.fromDateTime(checkOuTDateTime!)
                        .persianFormat(context)
                : 'ورود : '+checkInJalali.formatCompactDate() +
                    '\t | \t' +
                    TimeOfDay.fromDateTime(checkInDateTime)
                        .persianFormat(context),
          ),
        ),
      ),
    );
  }
}
