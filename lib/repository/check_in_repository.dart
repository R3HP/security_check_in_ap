import 'package:hive_flutter/adapters.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:security_check_in/model/check_in.dart';
import 'package:security_check_in/model/exception.dart';

abstract class CheckInRepository {
  Future<void> addCheckIn(CheckIn checkIn);
  Future<List<CheckIn>> getAllCheckIns();
  Future<List<CheckIn>> getRangedCheckIns(JalaliRange range);
  Future<void> updateCheckIn(CheckIn newCheckIn, int oldCheckInId);
  List<CheckIn> getFilteredCheckIns(String driverName);
  Future<void> clearBox();
}

class CheckInRepositoryImpl implements CheckInRepository {
  @override
  Future<void> addCheckIn(CheckIn checkIn) async {
    try {
      final checkInsBox = await Hive.openBox<CheckIn>(
        'checkIns',
      );
      await checkInsBox.add(checkIn);
      return;
    } catch (error) {
      throw MyException(message: error.toString());
    }
  }

  @override
  Future<List<CheckIn>> getAllCheckIns() async {
    try {
      final checkInsBox = await Hive.openBox<CheckIn>('checkIns');
      final response = checkInsBox
          .toMap()
          .entries
          .map((checkInKeyValuePair) =>
              checkInKeyValuePair.value.copyWith(id: checkInKeyValuePair.key))
          .toList()
        ..sort((checkIn1, checkIn2) =>
            checkIn2.checkInDate.compareTo(checkIn1.checkInDate));
      return response;
    } catch (error) {
      throw MyException(message: error.toString());
    }
  }

  @override
  Future<List<CheckIn>> getRangedCheckIns(JalaliRange range) async {
    try {
      final rangeStartDateTime = range.start.toDateTime();
      final rangeEndDateTime = range.end.toDateTime();
      final checkInsBox = await Hive.openBox<CheckIn>('checkIns');
      final checkIns = checkInsBox
          .toMap()
          .entries
          .map((checkInKeyValuePair) =>
              checkInKeyValuePair.value.copyWith(id: checkInKeyValuePair.key))
          .toList()
        ..sort((checkIn1, checkIn2) =>
            checkIn2.checkInDate.compareTo(checkIn1.checkInDate));
      final checkInsInRange = checkIns
          .where((checkIn) =>
              checkIn.checkInDate.isAfter(rangeStartDateTime) &&
              checkIn.checkInDate
                  .isBefore(rangeEndDateTime.add(const Duration(days: 1))))
          .toList();
      return checkInsInRange;
    } catch (error) {
      throw MyException(message: error.toString());
    }
  }

  @override
  Future<void> updateCheckIn(CheckIn newCheckIn, int oldCheckInId) async {
    try {
      final checkInBox = await Hive.openBox<CheckIn>('checkIns');
      final response = await checkInBox.put(oldCheckInId, newCheckIn);
      return response;
    } catch (error) {
      throw MyException(message: error.toString());
    }
  }

  @override
  List<CheckIn> getFilteredCheckIns(String driverName) {
    try {
      final checkInBox = Hive.box<CheckIn>('checkIns');
      final response = checkInBox.values
          .where((checkIn) => checkIn.driverName == driverName)
          .toList()
        ..sort((checkIn1, checkIn2) =>
            checkIn2.checkInDate.compareTo(checkIn1.checkInDate));
      return response;
    } catch (error) {
      throw MyException(message: error.toString());
    }
  }

  @override
  Future<void> clearBox() async {
    try {
      final checkInBox = Hive.box<CheckIn>('checkIns');
       await checkInBox.clear();
      return;
    } catch (error) {
      throw MyException(message: error.toString());
    }
  }
}
