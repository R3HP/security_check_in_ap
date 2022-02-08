import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:security_check_in/model/check_in.dart';
import 'package:security_check_in/view/widgets/add_check_in_bottom_sheet.dart';
import 'package:security_check_in/view/widgets/check_in_list_item.dart';
import 'package:security_check_in/view/widgets/delete_check_in_alert_dialog.dart';
import 'package:security_check_in/view/widgets/home_drawer.dart';
import 'package:security_check_in/view/widgets/ordered_check_in_list_view.dart';
import 'package:security_check_in/view/widgets/pick_check_in_range.dart';
import 'package:security_check_in/view_model/check_in_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/homeScreen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('نگهبانی'),
        actions: [
          IconButton(
              onPressed: () => showDeleteConfirmDialog(context),
              icon: Icon(
                Icons.delete_forever,
                color: Theme.of(context).colorScheme.onPrimary,
              ))
        ],
      ),
      drawer: const HomeDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        onPressed: () => showAddCheckInBottomSheet(context),
        child: const Icon(Icons.add_rounded),
      ),
      body: FutureBuilder(
        future: Hive.openBox<CheckIn>('checkIns'),
        builder: (context, AsyncSnapshot<Box<CheckIn>> snapshot) => snapshot
                    .connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Column(children: [
                const PickCheckInRange(),
                // if (checkInViewModel.checkIns != null)
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Text('از' +
                //           selectedRange!.start.formatCompactDate() +
                //           'الی ' +
                //           selectedRange!.end.formatCompactDate()),
                //       IconButton(
                //         onPressed: () {
                //           checkInViewModel.clearSearchCheckIns();
                //         },
                //         icon: const Icon(
                //           Icons.cancel_rounded,
                //           color: Colors.redAccent,
                //         ),
                //       )
                //     ],
                //   ),
                // if (checkInViewModel.checkIns == null)
                //   ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //         primary: Theme.of(context).colorScheme.secondary,
                //         onPrimary:
                //             Theme.of(context).colorScheme.onSecondary),
                //     onPressed: () {
                //       showPersianDateRangePicker(
                //               initialEntryMode: PDatePickerEntryMode.input,
                //               context: context,
                //               firstDate: Jalali(Jalali.now().year),
                //               lastDate: Jalali.now())
                //           .then((jalaliRange) {
                //         if (jalaliRange != null) {
                //           selectedRange = jalaliRange;
                //           checkInViewModel.getRangedCheckIns(jalaliRange);
                //         } else {
                //           checkInViewModel.clearSearchCheckIns();
                //         }
                //       }).catchError((error) {
                //         ScaffoldMessenger.of(context)
                //             .showSnackBar(FailureSnackBar());
                //       });
                //     },
                //     child: const Text('بازه زمانی خود را انتخاب کنید '),
                //   ),
                Consumer<CheckInViewModel>(
                  builder: (ctx, checkInViewModel, child) => Expanded(
                    child: checkInViewModel.checkIns == null
                        ? ValueListenableBuilder<Box<CheckIn>>(
                            valueListenable: snapshot.data!.listenable(),
                            builder: (context, value, child) =>
                                CheckInsOrderedListView(
                                    valuesMap: value.toMap()),
                          )
                        : checkInViewModel.checkIns!.isEmpty
                            ? const Center(
                                child: Text('موردی یافت نشد'),
                              )
                            : ListView.builder(
                                itemCount: checkInViewModel.checkIns!.length,
                                itemBuilder: (ctx, index) => CheckInListItem(
                                    checkIn:
                                        checkInViewModel.checkIns![index])),
                  ),
                ),
              ]),
      ),
    );
  }

  void showAddCheckInBottomSheet(BuildContext context) {
    showModalBottomSheet<CheckIn>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      elevation: 20,
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            curve: Curves.ease,
            duration: const Duration(milliseconds: 2),
            child: const AddCheckInBottomSheet(isEditing: false));
      },
    );
  }

  showDeleteConfirmDialog(BuildContext context) {
    showDialog(
        context: context, builder: (ctx) => const DeleteCheckInAlertDialog());
  }
}
