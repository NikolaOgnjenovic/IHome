import 'package:flutter/material.dart';

class Sensor {
  final String uid;
  final String name;
  final IconData icon;
  final bool isActive;

  Sensor({required this.uid, required this.name, required this.icon, required this.isActive});

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'icon': icon.codePoint,
    'isActive': isActive
  };

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
        uid: json['uid'] ?? '-1',
        name: json['name'] ?? 'Sensor name',
        icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
        isActive: json['isActive'] ?? false
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Sensor &&
              runtimeType == other.runtimeType &&
              uid == other.uid &&
              name == other.name &&
              icon == other.icon &&
              isActive == other.isActive;

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ icon.hashCode ^ isActive.hashCode;
}
