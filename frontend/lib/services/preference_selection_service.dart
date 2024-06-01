import 'dart:async';
import 'package:smart_home/repositories/preference_selection_repository.dart';
import 'package:smart_home/models/preference.dart';

class PreferenceSelectionService {
  final PreferenceSelectionRepository _repository = PreferenceSelectionRepository();

  Future<void> updatePreferences(List<Preference> preferences) async {
    await _repository.updatePreferences(preferences);
  }

  Future<List<Preference>> getPreferences() async {
    final preferences = await _repository.getPreferences();
    return preferences;
  }

  Future<void> clearSharedPrefs() async {
    await _repository.clearSharedPrefs();
  }

  Future<bool> hasSelectedPreferences() async {
    return await _repository.hasSelectedPreferences();
  }
}
