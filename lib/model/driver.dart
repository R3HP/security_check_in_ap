import 'dart:convert';

import 'package:hive/hive.dart';

part 'driver.g.dart';

@HiveType(typeId: 1)
class Driver extends HiveObject {
  int? id;
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String car;
  @HiveField(2)
  final String carId;
  @HiveField(3)
  final String imagePath;


  Driver({
    this.id,
    required this.name,
    required this.car,
    required this.carId,
    required this.imagePath
  });

  Driver copyWith({
    String? name,
    String? car,
    String? carId,
    int? id,
    String? imagePath
  }) {
    return Driver(
      id: id ?? this.id,
      name: name ?? this.name,
      car: car ?? this.car,
      carId: carId ?? this.carId,
      imagePath: imagePath ?? this.imagePath
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id' : id,
  //     'name': name,
  //     'car': car,
  //     'carId': carId,
  //   };
  // }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      id: map['id'],
      name: map['name'] ?? '',
      car: map['car'] ?? '',
      carId: map['carId'] ?? '',
      imagePath: map['imagePath'] ?? ''
    );
  }

  factory Driver.fromMapEntry(MapEntry<dynamic, dynamic> map) {
    return Driver(

      id: map.key,
      name: map.value['name'] ?? '',
      car: map.value['car'] ?? '',
      carId: map.value['carId'] ?? '',
      imagePath: map.value['imagePath'] ?? ''
    );
  }

  // String toJson() => json.encode(toMap());

  factory Driver.fromJson(String source) => Driver.fromMap(json.decode(source));

  @override
  String toString() => 'Driver(name: $name, car: $car, carId: $carId, imagePath: $imagePath)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true; 
    return other is Driver &&
      other.name == name &&
      other.car == car &&
      other.carId == carId;
  }

  @override
  int get hashCode => name.hashCode ^ car.hashCode ^ carId.hashCode;
}