import 'package:flutter/material.dart';
import '../models/preference.dart';

class PreferenceCard extends StatelessWidget {
  final Preference preference;
  final bool isSelected;
  final Function(bool) onSelected;

  const PreferenceCard({
    required this.preference,
    required this.isSelected,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected(!isSelected);
      },
      child: Card(
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
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
                preference.icon,
                size: 48, // Decreased icon size
                color: isSelected ? Colors.blue : Colors.grey[800],
              ),
              const SizedBox(height: 4),
              Text(
                preference.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12, // Decreased text size
                  color: isSelected ? Colors.blue : Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
