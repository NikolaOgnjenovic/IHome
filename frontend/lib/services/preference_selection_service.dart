import 'dart:async';
import 'dart:convert';
import 'package:smart_home/repositories/preference_selection_repository.dart';
import 'package:smart_home/models/preference.dart';
import 'package:http/http.dart' as http;

class PreferenceSelectionService {
  final PreferenceSelectionRepository _repository = PreferenceSelectionRepository();
  final Uri baseUri = Uri.parse('http://127.0.0.1:5000/preferences');

  Future<void> updatePreferences(List<Preference> preferences) async {
    final preferencesJson = preferences.map((preference) => preference.toJson()).toList();
    final response = await http.put(
      baseUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'preferences': preferencesJson}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update preferences: ${response.statusCode}');
    }
  }

  Future<List<Preference>> getPreferences() async {
    final response = await http.get(baseUri);

    if (response.statusCode == 200) {
      final List<dynamic> preferencesJson = jsonDecode(response.body);
      return preferencesJson.map((preferenceJson) => Preference.fromJson(preferenceJson)).toList();
    } else {
      throw Exception('Failed to load preferences: ${response.statusCode}');
    }
  }

  Future<void> clearSharedPrefs() async {
    await _repository.clearSharedPrefs();
  }

  Future<bool> hasSelectedPreferences() async {
    return await _repository.hasSelectedPreferences();
  }
}
