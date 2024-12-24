import 'dart:convert';
import 'package:carrent/core/ApiEndPoint.dart';
import 'package:carrent/core/GetDeviceId.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title ${message.notification?.title}");
  print("Body : ${message.notification?.body}");
  print("Playload: ${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    saveToken();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> saveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? deviceID = await getDeviceIdentifier();
    final fcmToken = await _firebaseMessaging.getToken();
    if (!isLoggedIn) {
      print("User is not logged in");
      return;
    }
    if (deviceID == "unknown" || deviceID == null) {
      print("Device ID is not found");
      return;
    }
    try {
      final response = await http.post(
          Uri.parse('${ApiEndpoints.apiUrl}/api/device-token'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({'deviceToken': fcmToken, 'playerId': deviceID}));

      if (response.statusCode == 200) {
        print('Token updated successfully');
      } else if (response.statusCode == 201) {
        print('Token saved successfully');
      } else {
        print('Failed to save token ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Server Error $e');
    }
  }
}
