import 'package:get_it/get_it.dart';
import 'package:security_check_in/repository/check_in_repository.dart';
import 'package:security_check_in/repository/driver_repository.dart';
import 'package:security_check_in/repository/theme_repository.dart';


final getIt = GetIt.instance;


inject(){

  // driver

  //repo
  getIt.registerLazySingleton<DriverRepository>(() => DriverRepositoryImpl());

  // checkin

  //repo
  getIt.registerLazySingleton<CheckInRepository>(() => CheckInRepositoryImpl());

  // theme

  //repo 
  getIt.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl());
}