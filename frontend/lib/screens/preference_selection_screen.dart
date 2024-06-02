import 'package:flutter/material.dart';
import '../models/preference.dart';
import '../services/preference_selection_service.dart';
import '../widgets/background_container.dart';
import '../widgets/preference_list_item.dart';

class PreferenceSelectionScreen extends StatefulWidget {
  const PreferenceSelectionScreen({Key? key}) : super(key: key);

  @override
  _PreferenceSelectionScreenState createState() =>
      _PreferenceSelectionScreenState();
}

class _PreferenceSelectionScreenState extends State<PreferenceSelectionScreen> {
  final PreferenceSelectionService _service = PreferenceSelectionService();
  List<Preference> _items = [];
  final Set<String> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final preferences = await _service.getPreferences();

    preferences.sort((a, b) => a.name.compareTo(b.name));

    setState(() {
      _items = preferences;
      for (var preference in preferences) {
        if (preference.isActive) {
          _selectedItems.add(preference.uid);
        }
      }
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

  void _updateExtraData(String uid, String extraData) {
    _service.updateExtraData(uid, extraData);
  }

  void _openExtraDataModal(Preference preference) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller =
        TextEditingController(text: preference.extraData ?? '');
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(left: 20), // Left padding
            child: const Text("Additional data"),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20), // Horizontal padding
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: preference.extraDataHint,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF373A40)),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
            IconButton(
              onPressed: () {
                _updateExtraData(preference.uid, controller.text);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.check),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 50),
              child: Text(
                'Actions',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13, top: 10),
              child: IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    final isSelected = _selectedItems.contains(item.uid);
                    return PreferenceListItem(
                      preference: item,
                      isSelected: isSelected,
                      onSelected: (isSelected) {
                        _toggleSelection(item);
                      },
                      onOpenExtraData: () {
                        _openExtraDataModal(item);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}