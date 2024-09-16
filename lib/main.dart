import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'remainder.dart';
import 'prediction.dart';
import 'scanner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Android-specific initialization
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBdGyLWxqBthhAbqpcOeBXTpxwtn8UX2tY',
      appId: '1:846684548309:android:9f3a693d704be4fca3465c',
      messagingSenderId: '846684548309',
      projectId: 'diabee-f0689',
    ),
  );

  tzdata.initializeTimeZones();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Broader blue line at the top (unchanged)
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 0.0,
              child: Container(
                height: 40.0,
                color: Colors.blueAccent,
              ),
            ),

            // Center the image and its related widgets
            Center(
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Minimize size for better positioning
                children: [
                  // App name above the image, made bolder (unchanged)
                  Text(
                    'DiaCare',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 34.0, // Adjust font size as desired
                      color: Colors.blueAccent, // Adjust text color
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                  ),

                  // Centered image (unchanged)
                  Image.asset('assets/diabetic.png'),

                  // Tagline below the image (unchanged)
                  Text(
                    'Healthy Living Made Easy: Your Personal Diabetic Assistant',
                    style: TextStyle(
                      fontSize: 15.0, // Adjust font size as desired
                      color: Colors.black, // Adjust text color
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center, // Center the text
                  ),
                ],
              ),
            ),

            // Row of icons at the top (icons are positioned absolutely)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Menu icon (three lines) at top left
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    // Handle menu button press (add your action here)
                  },
                ),

                // Settings icon at top right
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    // Handle settings button press (add your action here)
                  },
                ),
              ],
            ),

            // Row of icons at the bottom with adjustments (unchanged)
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 16.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.search, size: 30.0),
                      onPressed: () {
                        // Navigate to the prediction screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PredictionScreen()),
                        );
                      },
                    ),
                  ),
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.fastfood, size: 30.0),
                      onPressed: () {
                        // Navigate to the scanner screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScannerScreen()),
                        );
                      },
                    ),
                  ),
                  Icon(Icons.bar_chart, size: 30.0),
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.notifications, size: 30.0),
                      onPressed: () {
                        // Navigate to the remainder screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RemainderScreen()),
                        );
                      },
                    ),
                  ),
                  Icon(Icons.android, size: 30.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
