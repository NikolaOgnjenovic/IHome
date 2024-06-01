import 'package:flutter/material.dart';

class Preference {
  final String uid;
  final String name;
  final IconData icon;
  bool isActive;
  String? extraData;
  final String? extraDataHint;

  Preference({
    required this.uid,
    required this.name,
    required this.icon,
    required this.isActive,
    required this.extraData,
    required this.extraDataHint,
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'icon': icon.codePoint,
    'is_active': isActive,
    'extra_data': extraData,
    'extra_data_hint': extraDataHint,
  };

  factory Preference.fromJson(Map<String, dynamic> json) {
    return Preference(
      uid: json['uid'] ?? '-1',
      name: json['name'] ?? 'Preference name',
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      isActive: json['is_active'] ?? false,
      extraData: json['extra_data'],
      extraDataHint: json['extra_data_hint'],
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
              isActive == other.isActive &&
              extraData == other.extraData &&
              extraDataHint == other.extraDataHint;

  @override
  int get hashCode =>
      uid.hashCode ^
      name.hashCode ^
      icon.hashCode ^
      isActive.hashCode ^
      extraData.hashCode ^
      extraDataHint.hashCode;
}
