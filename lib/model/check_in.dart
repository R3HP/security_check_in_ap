import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

part 'check_in.g.dart';

@HiveType(typeId: 2)
class CheckIn {
  int? id;
  @HiveField(0)
  final String driverName;
  @HiveField(1)
  final DateTime checkInDate;
  @HiveField(3)
  final DateTime? checkoutDate;
  @HiveField(5)
  final int? numberOfPrepackBaskets;
  @HiveField(6)
  final int? numberOfFarahmandBaskets;
  @HiveField(7)
  final List<int>? shipmentIdList;
  CheckIn({
    this.id,
    required this.driverName,
    required this.checkInDate,
    this.checkoutDate,
    this.numberOfPrepackBaskets,
    this.numberOfFarahmandBaskets,
    this.shipmentIdList,
  });

  CheckIn copyWith({
    int? id,
    String? driverName,
    DateTime? checkInDate,
    DateTime? checkoutDate,
    int? numberOfPrepackBaskets,
    int? numberOfFarahmandBaskets,
    List<int>? shipmentIdList,
  }) {
    return CheckIn(
      id: id ?? this.id,
      driverName: driverName ?? this.driverName,
      checkInDate: checkInDate ?? this.checkInDate,
      checkoutDate: checkoutDate ?? this.checkoutDate,
      numberOfPrepackBaskets: numberOfPrepackBaskets ?? this.numberOfPrepackBaskets,
      numberOfFarahmandBaskets: numberOfFarahmandBaskets ?? this.numberOfFarahmandBaskets,
      shipmentIdList: shipmentIdList ?? this.shipmentIdList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'driverName': driverName,
      'checkInDate': checkInDate.toIso8601String(),
      'checkoutDate': checkoutDate?.toIso8601String(),
      'numberOfPrepackBaskets': numberOfPrepackBaskets,
      'numberOfFarahmandBaskets': numberOfFarahmandBaskets,
      'shipmentIdList': shipmentIdList,
    };
  }

  factory CheckIn.fromMap(Map<String, dynamic> map) {
    return CheckIn(
      id: map['id']?.toInt(),
      driverName: map['driverName'] ?? '',
      checkInDate: DateTime.parse(map['checkInDate']),
      checkoutDate: map['checkoutDate'] != null ? DateTime.parse(map['checkoutDate']): null,
      numberOfPrepackBaskets: map['numberOfPrepackBaskets']?.toInt(),
      numberOfFarahmandBaskets: map['numberOfFarahmandBaskets']?.toInt(),
      shipmentIdList: List<int>.from(map['shipmentIdList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckIn.fromJson(String source) => CheckIn.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CheckIn(id: $id, driverName: $driverName, checkInDate: $checkInDate, checkoutDate: $checkoutDate, numberOfPrepackBaskets: $numberOfPrepackBaskets, numberOfFarahmandBaskets: $numberOfFarahmandBaskets, shipmentIdList: $shipmentIdList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CheckIn &&
      other.id == id &&
      other.driverName == driverName &&
      other.checkInDate == checkInDate &&
      other.checkoutDate == checkoutDate &&
      other.numberOfPrepackBaskets == numberOfPrepackBaskets &&
      other.numberOfFarahmandBaskets == numberOfFarahmandBaskets &&
      listEquals(other.shipmentIdList, shipmentIdList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      driverName.hashCode ^
      checkInDate.hashCode ^
      checkoutDate.hashCode ^
      numberOfPrepackBaskets.hashCode ^
      numberOfFarahmandBaskets.hashCode ^
      shipmentIdList.hashCode;
  }
}
