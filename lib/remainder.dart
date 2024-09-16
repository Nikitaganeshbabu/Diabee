import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:timezone/timezone.dart' as tz;

class RemainderScreen extends StatefulWidget {
  @override
  _RemainderScreenState createState() => _RemainderScreenState();
}

class _RemainderScreenState extends State<RemainderScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medication Reminder'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Medication Reminder',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Medication Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Dosage',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Frequency (in hours)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: Text('Select Time'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Selected Time: ${_selectedTime.format(context)}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Medication reminder scheduled!'),
                  ),
                );

                // Print selectedDateTime for debugging
  var now = tz.TZDateTime.now(tz.local);
  var selectedDateTime = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    _selectedTime.hour,
    _selectedTime.minute,
  );
  print('Selected time for notification: $selectedDateTime');

                await _scheduleNotificationIfTimeMatches();
              },
              child: Text('Save Reminder'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Future<void> _scheduleNotificationIfTimeMatches() async {
    var now = tz.TZDateTime.now(tz.local);
    await requestNotificationPermission();
    var selectedDateTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    if (selectedDateTime.isAfter(now)) {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'medication_channel',
        'Medication Reminders',
        importance: Importance.max,
        priority: Priority.high,
        icon: 'app_icon',
        channelShowBadge: true, // Show badge even in Doze
      );
      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );

      await FlutterLocalNotificationsPlugin().zonedSchedule(
        0, // Notification ID (unique)
        'Medication Reminder',
        'Time to take your medication!',
        selectedDateTime, // Schedule for the selected time
        platformChannelSpecifics,
        payload: 'medication_reminder',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        // Required for zoned scheduling
      );
    }
  }

  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();

    switch (status) {
      case PermissionStatus.granted:
        print('Notification permission granted');
        
        break;
      case PermissionStatus.denied:
        print('Notification permission denied');
        break;
      case PermissionStatus.permanentlyDenied:
        print('Notification permission permanently denied');
        openAppSettings(); // Open app settings to allow user to change permissions
        break;
      case PermissionStatus.restricted:
        print('Notification permission restricted');
        break;
      default:
      print('Notification permission status: $status');
    }
  }
  // ...
}
