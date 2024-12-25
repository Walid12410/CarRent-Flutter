import 'package:carrent/core/ApiEndPoint.dart';
import 'package:carrent/model/Notification/NotificationModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  Future<List<NotificationModel>> fetchAllUserNotification(
      int page, int limit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';

    try {
      final response = await http.get(
          Uri.parse(
              '${ApiEndpoints.apiUrl}/api/notification/user-notification?pageNumber=$page&LimitPerPage=$limit'),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<NotificationModel> userNotification =
            jsonData.map((json) => NotificationModel.fromJson(json)).toList();
        return userNotification;
      } else {
        throw Exception('Failed to load Notification');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

  Future<void> deleteNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';

    try {
      final response = await http.delete(
          Uri.parse('${ApiEndpoints.apiUrl}/api/notification/user-notification'),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete Notification');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

}
