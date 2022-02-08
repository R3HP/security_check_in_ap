import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:security_check_in/dependency_injection.dart';
import 'package:security_check_in/model/check_in.dart';
import 'package:security_check_in/model/driver.dart';
import 'package:security_check_in/repository/check_in_repository.dart';
import 'package:security_check_in/repository/driver_repository.dart';
import 'package:security_check_in/repository/theme_repository.dart';
import 'package:security_check_in/view/screens/check_in_detail_screen.dart';
import 'package:security_check_in/view/screens/driver_details_screen.dart';
import 'package:security_check_in/view/screens/driver_screen.dart';
import 'package:security_check_in/view/screens/excell_export_screen.dart';
import 'package:security_check_in/view/screens/home_screen.dart';
import 'package:security_check_in/view/screens/settings_screen.dart';
import 'package:security_check_in/view/screens/splash_screen.dart';
import 'package:security_check_in/view_model/check_in_view_model.dart';
import 'package:security_check_in/view_model/driver_view_model.dart';
import 'package:security_check_in/view_model/theme_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  inject();
  await Hive.initFlutter();
  Hive.registerAdapter(CheckInAdapter());
  Hive.registerAdapter(DriverAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CheckInViewModel>(
          create: (context) =>
              CheckInViewModel(checkInRepository: getIt<CheckInRepository>()),
        ),
        ChangeNotifierProvider<DriverViewModel>(
          create: (context) =>
              DriverViewModel(driverRepository: getIt<DriverRepository>()),
        ),
        ChangeNotifierProvider<ThemeViewModel>(
            create: (context) =>
                ThemeViewModel(themeRepository: getIt<ThemeRepository>()))
      ],
      child: Builder(
        builder: (context) {
          return FutureBuilder(
            future: Provider.of<ThemeViewModel>(context,listen: false).initThemeData(),
            builder: (context, snapshot) =>  
            Consumer<ThemeViewModel>(
          
              builder: (context, value, child) =>  MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: value.defaultThemeData,
                // ThemeData(
                //   // This is the theme of your application.
                //   //
                //   // Try running your application with "flutter run". You'll see the
                //   // application has a blue toolbar. Then, without quitting the app, try
                //   // changing the primarySwatch below to Colors.green and then invoke
                //   // "hot reload" (press "r" in the console where you ran "flutter run",
                //   // or simply save your changes to "hot reload" in a Flutter IDE).
                //   // Notice that the counter didn't reset back to zero; the application
                //   // is not restarted.
                //   primarySwatch: Colors.indigo,
            
                //   // textButtonTheme: TextButtonThemeData(
                //   //   style: ButtonStyle(
                //   //     alignment: Alignment.center,
                //   //     // backgroundColor: MaterialStateProperty<Color>(11111)
                //   //   )
                //   // )
                // ),
                builder: (context, child) =>
                    Directionality(textDirection: TextDirection.rtl, child: child!),
                home: const SplashScreen(),
                // HomeScreen(),
                routes: {
                  HomeScreen.routeName: (ctx) => const HomeScreen(),
                  SettingsScreen.routeName : (ctx) => const SettingsScreen(),
                  DriverScreen.routeName: (ctx) => const DriverScreen(),
                  CheckDetailScreen.routeName: (ctx) => const CheckDetailScreen(),
                  ExportScreen.routeName: (ctx) => const ExportScreen(),
                  DriverDetailsScreen.routeName: (ctx) => const DriverDetailsScreen()
                },
              ),
            ),
          );
        }
      ),
    );
  }
}
