import 'dart:async';
import 'dart:convert';
import 'package:smart_home/repositories/preference_selection_repository.dart';
import 'package:smart_home/models/preference.dart';
import 'package:http/http.dart' as http;

class PreferenceSelectionService {
  final PreferenceSelectionRepository _repository = PreferenceSelectionRepository();
  final Uri baseUri = Uri.parse('http://127.0.0.1:5000/preferences');
  final Uri activateUri = Uri.parse('http://127.0.0.1:5000/preferences/activate');
  final Uri deactivateUri = Uri.parse('http://127.0.0.1:5000/preferences/deactivate');

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

  Future<void> setHasSelectedPreferences(bool value) async {
    return await _repository.setHasSelectedPreferences(value);
  }


  Future<void> activatePreference(String uid) async {
    final response = await http.patch(
      activateUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'uid': uid}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to activate preference: ${response.statusCode}');
    }
  }

  Future<void> deactivatePreference(String uid) async {
    final response = await http.patch(
      deactivateUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'uid': uid}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to deactivate preference: ${response.statusCode}');
    }
  }

  Future<void> updateExtraData(String uid, String extraData) async {
    final updateUri = Uri.parse('http://127.0.0.1:5000/preferences/$uid');
    final response = await http.patch(
      updateUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'extra_data': extraData}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update extra data for preference: ${response.statusCode}');
    }
  }
}
