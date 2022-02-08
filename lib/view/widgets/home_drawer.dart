import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_check_in/view/screens/driver_screen.dart';
import 'package:security_check_in/view/screens/excell_export_screen.dart';
import 'package:security_check_in/view/screens/settings_screen.dart';
import 'package:security_check_in/view_model/check_in_view_model.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      child: DrawerHeader(child: Column(
        children: [
          ListTile(
            title: const Text('اضافه کردن راننده '),
            onTap: () => Navigator.of(context).pushNamed(DriverScreen.routeName),
          ),
          ListTile(
            title: const Text('خروجی اکسل'),
            onTap: () {
              Provider.of<CheckInViewModel>(context,listen: false).clearSearchCheckIns();
              Navigator.of(context).pushNamed(ExportScreen.routeName).then((value) => Provider.of<CheckInViewModel>(context,listen: false).clearSearchCheckIns());
            },
          ),
          ListTile(
            title: const Text('تنظیمات'),
            onTap: () => Navigator.of(context).pushNamed(SettingsScreen.routeName),
          )
        ],
      )),
    );
  }
}