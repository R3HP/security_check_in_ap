import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';

import 'package:security_check_in/repository/theme_repository.dart';

class ThemeViewModel extends ChangeNotifier {
  final ThemeRepository themeRepository;

  ThemeViewModel({
    required this.themeRepository,
  });

  static final  _colors = <MaterialColor>[
    Colors.indigo,
    MaterialColor(Colors.black.value, const <int, Color>{ 
      50: Color(0xffce5641),//10% 
      100: Color(0xffb74c3a),//20% 
      200: Color(0xffa04332),//30% 
      300: Color(0xff89392b),//40% 
      400: Color(0xff733024),//50% 
      500: Color(0xff5c261d),//60% 
      600: Color(0xff451c16),//70% 
      700: Color(0xff2e130e),//80% 
      800: Color(0xff170907),//90% 
      900: Color(0xff000000),//100% 
    },),
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.deepOrange
  ];

  int index = 0;


  List<MaterialColor> get colors{
    return _colors;
  }


  ThemeData defaultThemeData = ThemeData(
    textTheme: const TextTheme(
      bodyText1: PersianFonts.Sahel
    ),
    primarySwatch: _colors[0]
  );


  Future<void> initThemeData() async {
    final themeIndex = await themeRepository.initTheme();
    changeThemeColor(themeIndex);
    index = themeIndex;
  }



  void changeThemeColor(int index){
    if(index == 1 ){
      defaultThemeData = ThemeData.dark();
    }else{
    defaultThemeData = ThemeData(primarySwatch: _colors[index]);
    }
    this.index = index;
    updateThemeInDB(index);
    notifyListeners();
  }

  updateThemeInDB(int themeIndex) async {
    await themeRepository.updateThemeInDb(themeIndex);
  }
}
