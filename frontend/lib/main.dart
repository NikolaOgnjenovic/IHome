import 'package:flutter/material.dart';
import 'package:smart_home/screens/preference_selection_screen.dart';
import 'package:smart_home/screens/sensor_selection_screen.dart';
import 'package:smart_home/services/preference_selection_service.dart';
import 'package:smart_home/services/sensor_selection_service.dart';
import 'package:smart_home/widgets/background_container.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        fontFamily: 'Poppins',
        cardColor: const Color(0xFFF6F1F1),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: Color(0xFF373A40),
              fontSize: 48,
              fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: Color(0xFF373A40), fontSize: 20),
          displaySmall: TextStyle(color: Color(0xFF373A40), fontSize: 16),
          labelLarge: TextStyle(color: Colors.white),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFEEEEEE),
          selectionColor: Color(0xFFEEEEEE),
          selectionHandleColor: Color(0xFFEEEEEE),
        )),
    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(),
      '/preference-selection': (context) => const PreferenceSelectionScreen(),
      '/sensor-selection': (context) => const SensorSelectionScreen()
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
  final sensorSelectionService = SensorSelectionService();

  @override
  void initState() {
    super.initState();
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
                'Smart home',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Your home, smarter than ever',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: buildIconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/preference-selection');
                      },
                      icon: Icons.settings,
                      label: 'Actions',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: buildIconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sensor-selection');
                      },
                      icon: Icons.thermostat,
                      label: 'Active sensors',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconButton(
      {required VoidCallback onPressed,
      required IconData icon,
      required String label}) {
    return SizedBox(
      height: 60,
      child: TextButton.icon(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
          overlayColor: WidgetStateProperty.all<Color>(const Color(0x00EEEEEE)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: Text(
          label,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
