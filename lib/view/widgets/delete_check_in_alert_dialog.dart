import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_check_in/view_model/check_in_view_model.dart';

class DeleteCheckInAlertDialog extends StatelessWidget {
  const DeleteCheckInAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          content: RichText(
            text: const TextSpan(children: [
              TextSpan(
                  text: 'این عملیات تمامی ورود و خروج ها را حذف میکند ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  )),
              TextSpan(text: '\n'),
              TextSpan(
                  text:
                      'پیشنهاد میکنیم قبل از حذف از داده های خود خروجی تهیه کنید ',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey)),
            ]),
          ),
          title: const Text('آیا مطمئن هستید'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Provider.of<CheckInViewModel>(context, listen: false)
                    .clearBox()
                    .then((value) => Navigator.of(context).pop())
                    .then((value) => ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                            content: Text('داده ها پاک شدند '))));
              },
              child: const Text('حذف'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('بازگشت'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onPrimary: Colors.indigoAccent,
                  elevation: 0,
                  side: const BorderSide(color: Colors.indigoAccent)),
            ),
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
        );
  }
}