import 'package:flutter/material.dart';

class Preference {
  final String name;
  final IconData icon;

  Preference({required this.name, required this.icon});

  Map<String, dynamic> toJson() => {
    'name': name,
    'icon': icon.codePoint,
  };

  factory Preference.fromJson(Map<String, dynamic> json) {
    return Preference(
      name: json['name'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Preference &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              icon == other.icon;

  @override
  int get hashCode => name.hashCode ^ icon.hashCode;
}
