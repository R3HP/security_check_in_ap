import 'package:flutter/material.dart';
import 'package:security_check_in/model/check_in.dart';

import 'check_in_list_item.dart';

class CheckInsOrderedListView extends StatelessWidget {
  final Map<dynamic,CheckIn> valuesMap;
  const CheckInsOrderedListView({  
    Key? key,
    required this.valuesMap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedValues = valuesMap
        .entries
        .map<CheckIn>(
            (e) => e.value.copyWith(id: e.key))
        .toList()
      ..sort((checkIn1, checkIn2) => checkIn2
          .checkInDate
          .compareTo(checkIn1.checkInDate));
    return ListView.builder(
        itemCount: sortedValues.length,
        itemBuilder: (context, index) =>
            CheckInListItem(
                checkIn: sortedValues
                    .elementAt(index)));
  }
}
