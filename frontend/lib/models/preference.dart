import 'package:flutter/material.dart';

class Preference {
  final String uid;
  final String name;
  final IconData icon;

  Preference({required this.uid, required this.name, required this.icon});

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'icon': icon.codePoint,
  };

  factory Preference.fromJson(Map<String, dynamic> json) {
    return Preference(
      uid: json['uid'],
      name: json['name'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Preference &&
              runtimeType == other.runtimeType &&
              uid == other.uid &&
              name == other.name &&
              icon == other.icon;

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ icon.hashCode;
}
