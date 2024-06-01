import 'package:flutter/material.dart';
import '../models/preference.dart';

class PreferenceCard extends StatefulWidget {
  final Preference preference;
  final bool isSelected;
  final Function(bool) onSelected;
  final Function(String) onSaveExtraData;

  const PreferenceCard({
    required this.preference,
    required this.isSelected,
    required this.onSelected,
    required this.onSaveExtraData,
    Key? key,
  }) : super(key: key);

  @override
  _PreferenceCardState createState() => _PreferenceCardState();
}

class _PreferenceCardState extends State<PreferenceCard> {
  late TextEditingController _extraDataController;

  @override
  void initState() {
    super.initState();
    _extraDataController = TextEditingController(text: widget.preference.extraData);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelected(!widget.isSelected);
      },
      child: Card(
        color: widget.isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.preference.icon,
                size: 48,
                color: widget.isSelected ? Colors.blue : Colors.grey[800],
              ),
              const SizedBox(height: 4),
              Text(
                widget.preference.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: widget.isSelected ? Colors.blue : Colors.grey[800],
                ),
              ),
              if (widget.preference.extraDataHint != null) ...[
                const SizedBox(height: 8),
                TextField(
                  controller: _extraDataController,
                  onChanged: (value) {
                  },
                  decoration: InputDecoration(
                    hintText: widget.preference.extraDataHint!,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    widget.onSaveExtraData(_extraDataController.text);
                  },
                  child: const Text('Save'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
