import 'package:hive_flutter/hive_flutter.dart';

abstract class ThemeRepository {
  Future<int> initTheme();
  Future<void> updateThemeInDb(int index);
}

class ThemeRepositoryImpl extends ThemeRepository {
  @override
  Future<int> initTheme() async {
    final themeBox = await Hive.openBox<int>('themes');
    final themeIndex = themeBox.get('themeColorIndex', defaultValue: 0);
    if (themeBox.isOpen) {
      await themeBox.close();
    }
    return themeIndex!;
  }

  @override
  Future<void> updateThemeInDb(int index) async {
    final themeBox = await Hive.openBox<int>('themes');
    themeBox.put('themeColorIndex', index);
    if (themeBox.isOpen) {
      await themeBox.close();
    }
    return;
  }
}
