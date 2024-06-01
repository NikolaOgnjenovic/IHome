import 'package:flutter/material.dart';
import 'package:smart_home/screens/preference_selection_screen.dart';
import 'package:smart_home/services/preference_selection_service.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(),
      '/preference-selection': (context) => const PreferenceSelectionScreen(),
    },
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final preferenceSelectionService = PreferenceSelectionService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    preferenceSelectionService.hasSelectedPreferences().then((hasSelected) {
      if (!hasSelected) {
        Navigator.pushReplacementNamed(context, '/preference-selection');
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Smart home',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/preference-selection');
              },
              child: const Text('Preferred actions'),
            ),
          ],
        ),
      ),
    );
  }
}
