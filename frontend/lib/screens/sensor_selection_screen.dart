import 'package:flutter/material.dart';
import '../models/sensor.dart';
import '../services/sensor_selection_service.dart';
import '../widgets/sensor_card.dart';

class SensorSelectionScreen extends StatefulWidget {
  const SensorSelectionScreen({Key? key}) : super(key: key);

  @override
  _SensorSelectionScreenState createState() => _SensorSelectionScreenState();
}

class _SensorSelectionScreenState extends State<SensorSelectionScreen> {
  final SensorSelectionService _service = SensorSelectionService();
  final List<Sensor> _items = [
    Sensor(id: 'a1', name: 'Temperature', icon: Icons.thermostat),
    Sensor(id: 'b2', name: 'Motion', icon: Icons.directions_walk),
    Sensor(id: 'c3', name: 'Humidity', icon: Icons.waves),
    Sensor(id: 'd4', name: 'CO2', icon: Icons.cloud),
  ];
  final Set<Sensor> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    _loadSensors();
  }

  Future<void> _loadSensors() async {
    final sensors = await _service.getSensors();
    setState(() {
      _selectedItems.addAll(sensors);
    });
  }

  Future<void> _clearSharedPrefs() async {
    await _service.clearSharedPrefs();
    setState(() {
      _selectedItems.clear();
    });
  }

  void _toggleSelection(Sensor sensor, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(sensor);
      } else {
        _selectedItems.remove(sensor);
      }
    });
  }

  Future<void> _navigateToNextScreen() async {
    Navigator.pushNamed(context, '/');
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
                        'Select your active sensors',
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
                  return SensorCard(
                    sensor: item,
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
                    child: const Text('Clear Sensors'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _service.updateSensors(_selectedItems.toList());
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
