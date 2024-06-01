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

  final List<Preference> _items = [
    Preference(name: 'Eating ice cream', icon: Icons.icecream),
    Preference(name: 'Going to the beach', icon: Icons.beach_access),
    Preference(name: 'Listening to music', icon: Icons.music_note),
    Preference(name: 'Reading books', icon: Icons.book),
    Preference(name: 'Playing video games', icon: Icons.videogame_asset),
    Preference(name: 'Travelling', icon: Icons.airplanemode_active),
    Preference(name: 'Watching movies', icon: Icons.movie),
    Preference(name: 'Cycling', icon: Icons.directions_bike),
    Preference(name: 'Cooking', icon: Icons.local_dining),
    Preference(name: 'Hiking', icon: Icons.terrain),
  ];
  final Set<Preference> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final preferences = await _service.getPreferences();
    setState(() {
      _selectedItems.addAll(preferences);
    });
  }

  Future<void> _clearSharedPrefs() async {
    await _service.clearSharedPrefs();
    setState(() {
      _selectedItems.clear();
    });
  }

  void _toggleSelection(Preference preference, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(preference);
      } else {
        _selectedItems.remove(preference);
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Remove the default app bar
      body: Column(
        children: [
          Container(
            color: Colors.brown[700],
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top), // To avoid the top padding
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to previous screen
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Select your preferred actions', // Updated title
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
                  final isSelected = _selectedItems.contains(item);
                  return PreferenceCard(
                    preference: item,
                    isSelected: isSelected,
                    onSelected: (isSelected) {
                      _toggleSelection(item, isSelected);
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
                      await _service.updatePreferences(_selectedItems.toList());
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
