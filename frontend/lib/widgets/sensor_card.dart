import 'package:flutter/material.dart';
import '../models/sensor.dart';

class SensorCard extends StatelessWidget {
  final Sensor sensor;
  final bool isSelected;
  final Function(bool) onSelected;

  const SensorCard({
    required this.sensor,
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
                sensor.icon,
                size: 48, // Adjust icon size as needed
                color: isSelected ? Colors.blue : Colors.grey[800],
              ),
              const SizedBox(height: 4),
              Text(
                sensor.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12, // Adjust text size as needed
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
