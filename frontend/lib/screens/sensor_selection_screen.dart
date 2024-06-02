import 'package:flutter/material.dart';
import '../models/sensor.dart';
import '../services/sensor_selection_service.dart';
import '../widgets/background_container.dart';
import '../widgets/sensor_list_item.dart';

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
      for (var sensor in sensors) {
        if (sensor.isActive) {
          _selectedItems.add(sensor.uid);
        }
      }
    });
  }

  void _toggleSelection(Sensor sensor) {
    setState(() {
      if (sensor.isActive) {
        _selectedItems.remove(sensor.uid);
        _service.deactivateSensor(sensor.uid);
      } else {
        _selectedItems.add(sensor.uid);
        _service.activateSensor(sensor.uid);
      }

      sensor.isActive = !sensor.isActive;
    });
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
              'Active sensors',
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
                  return SensorListItem(
                    sensor: item,
                    isSelected: isSelected,
                    onSelected: (isSelected) {
                      _toggleSelection(item);
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, top: 10),
            child: IconButton(
              icon: const Icon(Icons.music_note),
              onPressed: () {
                _service.playVideo("Shine On You Crazy Diamond");
              },
            ),
          ),
        ],
      ),
    ));
  }
}
