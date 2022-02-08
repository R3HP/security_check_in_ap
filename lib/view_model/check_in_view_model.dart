import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:security_check_in/model/check_in.dart';
import 'package:security_check_in/model/failure.dart';
import 'package:security_check_in/repository/check_in_repository.dart';

class CheckInViewModel with ChangeNotifier {
  List<CheckIn>? checkIns;

  final CheckInRepository checkInRepository;

  CheckInViewModel({
    required this.checkInRepository,
  });

  void clearSearchCheckIns() {
    // checkIns.clear();
    checkIns = null;
    notifyListeners();
  }

  Future<void> clearBox() async {
    try {
      clearSearchCheckIns();
      await checkInRepository.clearBox();
      return;
    } catch (error) {
      throw MyFailure(message: error.toString());
    }
  }

  Future<void> getRangedCheckIns(JalaliRange range) async {
    try {
      final response = await checkInRepository.getRangedCheckIns(range);
      checkIns = response;
      notifyListeners();
      return;
    } catch (error) {
      throw MyFailure(message: error.toString());
    }
  }

  Future<void> getAllCheckIns() async {
    try {
      final response = await checkInRepository.getAllCheckIns();
      checkIns = response;
      notifyListeners();
    } catch (error) {
      throw MyFailure(message: error.toString());
    }
  }

  Future<void> addNewCheckIn(CheckIn checkIn) async {
    try {
      final response = await checkInRepository.addCheckIn(checkIn);
      // getAllCheckIns();
      return response;
    } catch (error) {
      throw MyFailure(message: error.toString());
    }
  }

  Future<void> updateCheckIn(CheckIn newCheckIn, int oldCheckInId) async {
    try {
      final response =
          await checkInRepository.updateCheckIn(newCheckIn, oldCheckInId);
      return response;
    } catch (error) {
      throw MyFailure(message: error.toString());
    }
  }

  List<CheckIn> getFilteredCheckIns(String driverName) {
    try {
      final response = checkInRepository.getFilteredCheckIns(driverName);
      return response;
    } catch (error) {
      throw MyFailure(message: error.toString());
    }
  }
}
