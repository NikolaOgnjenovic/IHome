import 'package:flutter/material.dart';
import '../models/sensor.dart';
import '../services/sensor_selection_service.dart';
import '../widgets/sensor_card.dart';

class SensorSelectionScreen extends StatefulWidget {
  const SensorSelectionScreen({Key? key});

  @override
  _SensorSelectionScreenState createState() => _SensorSelectionScreenState();
}

class _SensorSelectionScreenState extends State<SensorSelectionScreen> {
  final SensorSelectionService _service = SensorSelectionService();
  List<Sensor> _items = [];
  final Set<String> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    _loadSensors();
  }

  Future<void> _loadSensors() async {
    final sensors = await _service.getSensors();
    setState(() {
      _items = sensors;
    });
  }

  void _toggleSelection(String uid, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(uid);
        _service.deactivateSensor(uid);
      } else {
        _selectedItems.remove(uid);
        _service.activateSensor(uid);
      }
    });
  }

  Future<void> _clearSharedPrefs() async {
    await _service.clearSharedPrefs();
    setState(() {
      _selectedItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          // AppBar and other UI components
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 3.0,
                children: _items.map((item) {
                  final isSelected = _selectedItems.contains(item.uid);
                  return SensorCard(
                    sensor: item,
                    isSelected: isSelected,
                    onSelected: (isSelected) {
                      _toggleSelection(item.uid, isSelected);
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
                      _service.setHasSelectedSensors(true);
                      await Navigator.pushNamed(context, '/');
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
