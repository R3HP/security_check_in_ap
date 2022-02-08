import 'package:hive_flutter/adapters.dart';
import 'package:security_check_in/model/driver.dart';
import 'package:security_check_in/model/exception.dart';

abstract class DriverRepository {
  Future<void> insertDriverToDatabase(Driver newDriver);
  Future<List<Driver>> searchForADriverName(String driverName);
  Future<List<Driver>> getAllDrivers();
  Future<void> deleteDriver(int driverId);
}

class DriverRepositoryImpl implements DriverRepository {
  @override
  Future<void> insertDriverToDatabase(Driver newDriver) async {
    try {
      var driversBox = await Hive.openBox<Driver>('drivers');
      await driversBox.add(newDriver);
      // await driversBox.close();
      // print(response);
      return;
    } catch (error) {
      throw MyException(message: error.toString());
    }
  }

  @override
  Future<List<Driver>> searchForADriverName(String driverName) async {
    try {
      final driverBox = await Hive.openBox<Driver>('drivers');
      final response = driverBox.values
          .where((driver) => driver.name.contains(driverName))
          .toList();
      return response;
    } catch (error) {
      throw MyException(message: error.toString());
    }
  }

  @override
  Future<List<Driver>> getAllDrivers() async {
    try {
      final driverBox = await Hive.openBox<Driver>('drivers');
      final response = driverBox
          .toMap()
          .entries
          .map((e) => e.value.copyWith(id: e.key))
          .toList();
      await driverBox.close();
      // final resposne = driverBox.toMap().entries.map((driverMap) {
      //   print(driverMap);
      //   return Driver.fromMapEntry(driverMap);
      // }).toList();

      return response;
    } catch (error) {
      throw MyException(message: error.toString());
    }
  }

  @override
  Future<void> deleteDriver(int driverId) async {
    try {
      final driverBox = await Hive.openBox<Driver>('drivers');
      await driverBox.delete(driverId);
      return;
    } catch (error) {
      throw MyException(message: error.toString());
    }
  }
}
