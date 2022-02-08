import 'package:flutter/cupertino.dart';
import 'package:security_check_in/model/driver.dart';
import 'package:security_check_in/model/failure.dart';
import 'package:security_check_in/repository/driver_repository.dart';

class DriverViewModel with ChangeNotifier {
  final DriverRepository driverRepository;

  List<Driver>? driversList;

  DriverViewModel({
    required this.driverRepository,
  });

  clearDriverList() {
    driversList = null;
    notifyListeners();
  }

  Future<void> deleteDriver(int driverId) async {
    try {
      await driverRepository.deleteDriver(driverId);
      clearDriverList();
      return;
    } catch (error) {
      throw MyFailure(message: error.toString());
    }
  }

  Future<List<Driver>> getAllDrivers() async {
    try {
      final response = await driverRepository.getAllDrivers();

      return response;
    } catch (error) {
      throw MyFailure(message: error.toString());
    }
  }

  void searchForADriverName(String driverName) async {
    try {
      final response = await driverRepository.searchForADriverName(driverName);
      driversList = response;
      notifyListeners();
    } catch (error) {
      throw MyFailure(message: error.toString());
    }
  }

  Future<void> createNewDriverAndAddToDatabase(
      String name, String car, String carId, String imagePath) async {
    final newDriver =
        Driver(name: name, car: car, carId: carId, imagePath: imagePath);
    try {
      final response = await driverRepository.insertDriverToDatabase(newDriver);
      return response;
    } catch (error) {
      throw MyFailure(message: error.toString());
    }
  }
}
