import 'package:smart_home/repositories/preference_selection_repository.dart';
import 'package:smart_home/models/preference.dart';

class PreferenceSelectionService {
  final PreferenceSelectionRepository _repository = PreferenceSelectionRepository();

  Future<void> updatePreferences(List<Preference> preferences) async {
    await _repository.updatePreferences(preferences);
  }

  Future<List<Preference>> getPreferences() async {
    return await _repository.getPreferences();
  }

  Future<void> clearPreferences() async {
    return await _repository.clearPreferences();
  }
}
