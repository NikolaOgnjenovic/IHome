import 'package:flutter/material.dart';
import '../models/preference.dart';
import '../services/preference_selection_service.dart';
import '../services/sensor_selection_service.dart';
import '../widgets/preference_card.dart';

class PreferenceSelectionScreen extends StatefulWidget {
  const PreferenceSelectionScreen({super.key});

  @override
  _PreferenceSelectionScreenState createState() => _PreferenceSelectionScreenState();
}

class _PreferenceSelectionScreenState extends State<PreferenceSelectionScreen> {
  final PreferenceSelectionService _service = PreferenceSelectionService();
  final SensorSelectionService _sensorService = SensorSelectionService();

  List<Preference> _items = [];
  final Set<String> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final preferences = await _service.getPreferences();
    setState(() {
      _items = preferences;
      for (var preference in preferences) {
        if (preference.isActive) {
          _selectedItems.add(preference.uid);
        }
      }
    });
  }

  Future<void> _clearSharedPrefs() async {
    await _service.clearSharedPrefs();
    setState(() {
      _selectedItems.clear();
    });
  }

  void _toggleSelection(Preference preference) {
    setState(() {
      if (preference.isActive) {
        _selectedItems.remove(preference.uid);
        _service.deactivatePreference(preference.uid);
      } else {
        _selectedItems.add(preference.uid);
        _service.activatePreference(preference.uid);
      }

      preference.isActive = !preference.isActive;
    });
  }

  Future<void> _navigateToNextScreen() async {
    final hasSelectedSensors = await _sensorService.hasSelectedSensors();
    if (!hasSelectedSensors) {
      Navigator.pushNamed(context, '/sensor-selection');
    } else {
      Navigator.pushNamed(context, '/');
    }
  }

  void _updateExtraData(String uid, String extraData) {
    _service.updateExtraData(uid, extraData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Container(
            color: Colors.brown[700],
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Select your preferred actions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 3.0,
                children: _items.map((item) {
                  final isSelected = _selectedItems.contains(item.uid);
                  return PreferenceCard(
                    preference: item,
                    isSelected: isSelected,
                    onSelected: (isSelected) {
                      _toggleSelection(item);
                    },
                    onSaveExtraData: (String extraData) {
                      _updateExtraData(item.uid, extraData);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _clearSharedPrefs();
                    },
                    child: const Text('Clear Preferences'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _service.setHasSelectedPreferences(true);
                      await _navigateToNextScreen();
                    },
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}