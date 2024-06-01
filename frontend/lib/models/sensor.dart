import 'package:flutter/material.dart';

class Sensor {
  final String id;
  final String name;
  final IconData icon;

  Sensor({required this.id, required this.name, required this.icon});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'icon': icon.codePoint,
  };

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      id: json['id'],
      name: json['name'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Sensor &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              icon == other.icon;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ icon.hashCode;
}
