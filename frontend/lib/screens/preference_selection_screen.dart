import 'package:flutter/material.dart';
import '../models/preference.dart';
import '../services/preference_selection_service.dart';

class PreferenceSelectionScreen extends StatefulWidget {
  const PreferenceSelectionScreen({super.key});

  @override
  _PreferenceSelectionScreenState createState() => _PreferenceSelectionScreenState();
}

class _PreferenceSelectionScreenState extends State<PreferenceSelectionScreen> {
  final PreferenceSelectionService _service = PreferenceSelectionService();
  final List<Preference> _items = [
    Preference(name: 'Eating ice cream', icon: Icons.icecream),
    Preference(name: 'Going to the beach', icon: Icons.beach_access),
    Preference(name: 'Listening to music', icon: Icons.music_note),
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

  Future<void> _clearPreferences() async {
    await _service.clearPreferences();
    setState(() {
      _selectedItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select your preferences'),
        backgroundColor: Colors.brown[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final isSelected = _selectedItems.contains(item);
                return Card(
                  child: ListTile(
                    leading: Icon(item.icon),
                    title: Text(item.name),
                    trailing: Checkbox(
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedItems.add(item);
                          } else {
                            _selectedItems.remove(item);
                          }
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await _service.updatePreferences(_selectedItems.toList());
              // TODO: Navigate to another screen or show a confirmation
            },
            child: const Text('Continue'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _clearPreferences();
              // TODO: Provide user feedback that preferences have been cleared
            },
            child: const Text('Clear Preferences'),
          ),
        ],
      ),
    );
  }
}
