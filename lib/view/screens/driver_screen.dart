import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:security_check_in/model/driver.dart';
import 'package:security_check_in/view/widgets/add_driver_bottom_sheet.dart';
import 'package:security_check_in/view/widgets/driver_list_item.dart';
import 'package:security_check_in/view_model/driver_view_model.dart';

class DriverScreen extends StatelessWidget {
  const DriverScreen({Key? key}) : super(key: key);

  static const routeName = '/drivers_screen';

  @override
  Widget build(BuildContext context) {
    final driverViewModel =
        Provider.of<DriverViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('مدیریت راننده'),
        actions: [
          IconButton(
              onPressed: () {
                showAddDriverBottomSheet(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Hive.openBox<Driver>('drivers'),
        builder: (ctx, AsyncSnapshot<Box<Driver>> box) => box.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        if (value.isEmpty) {
                          // print('value is empty: $value');
                          driverViewModel.clearDriverList();
                        } else {
                          driverViewModel.searchForADriverName(value);
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: 'نام راننده مورد نظر را جستجو کنید',
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Consumer<DriverViewModel>(
                      builder: (context, driverViewModel, child) {
                        // print(
                        //     'driverList : ${driverViewModel.driverList.length}');
                        return driverViewModel.driversList == null
                            ? ValueListenableBuilder(
                                valueListenable: box.data!.listenable(),
                                builder: (ctx, Box<Driver> box, _) {
                                  final drivers = box
                                      .toMap()
                                      .entries
                                      .map<Driver>(
                                          (e) => e.value.copyWith(id: e.key))
                                      .toList();
                                  return ListView.builder(
                                    itemCount: drivers.length,
                                    itemBuilder: (ctx, index) => DriverListItem(
                                        driver: drivers.elementAt(index)),
                                  );
                                },
                              )
                            : driverViewModel.driversList!.isEmpty
                                ? const Center(
                                    child: Text('موردی یافت نشد'),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        driverViewModel.driversList!.length,
                                    itemBuilder: (ctx, index) => DriverListItem(
                                        driver: driverViewModel
                                            .driversList![index]),
                                  );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void showAddDriverBottomSheet(BuildContext context) {
    showModalBottomSheet(
      elevation: 20,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => const AddDriverBottomSheet(),
    );
  }
}
