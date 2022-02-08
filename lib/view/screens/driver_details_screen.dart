import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

import 'package:security_check_in/model/driver.dart';
import 'package:security_check_in/view/screens/excell_export_screen.dart';
import 'package:security_check_in/view/widgets/check_in_list_item.dart';
import 'package:security_check_in/view_model/check_in_view_model.dart';

class DriverDetailsScreen extends StatelessWidget {
  static const routeName = '/driver_details';

  const DriverDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final driver = args['driver'] as Driver;
    final checkInViewModel =
        Provider.of<CheckInViewModel>(context, listen: false);
    final list = checkInViewModel.getFilteredCheckIns(driver.name);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            stretch: true,
            centerTitle: true,
            pinned: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                  tag: driver.name,
                  child: FadeInImage(
                    fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset('assets/images/user_2.png',fit: BoxFit.cover),
                      placeholder: const AssetImage(
                        'assets/image/user_2.png',
                      ),
                      image: FileImage(File(driver.imagePath)))),
              title: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10,left: 50),
                      child: Text(driver.name),
                    ),
                  ),
                ),
              ),
            ),
          ),
          list.isEmpty
              ? const SliverToBoxAdapter(
                  child: Center(
                    child: Text('موردی یافت نشد'),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(

                    (ctx, index) => CheckInListItem(checkIn: list[index]),
                    childCount: list.length
                  ),
                ),
                if(list.isNotEmpty)
                SliverToBoxAdapter(
                  child: ElevatedButton.icon(
                    
                    icon: const Icon(Icons.import_export_rounded),
                    onPressed: () {
                    Provider.of<CheckInViewModel>(context,listen: false).checkIns = list;
                    Navigator.of(context).pushNamed(ExportScreen.routeName,arguments: {'selectedRange' : JalaliRange(start: Jalali.fromDateTime(list.last.checkInDate) , end: Jalali.fromDateTime(list.first.checkInDate)),'driverName' : driver.name});
                  }, label: const Text('خروجی')),
                )
                
        ],
      ),
    );
  }
}
