import 'package:flutter/material.dart';

class Preference {
  final String uid;
  final String name;
  final IconData icon;
  bool isActive;

  Preference({required this.uid, required this.name, required this.icon, required this.isActive});

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'icon': icon.codePoint,
    'isActive': isActive
  };

  factory Preference.fromJson(Map<String, dynamic> json) {
    return Preference(
      uid: json['uid'] ?? '-1',
      name: json['name'] ?? 'Preference name',
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      isActive: json['is_active'] ?? false
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Preference &&
              runtimeType == other.runtimeType &&
              uid == other.uid &&
              name == other.name &&
              icon == other.icon &&
              isActive == other.isActive;

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ icon.hashCode & isActive.hashCode;
}
