import 'dart:convert';
import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/Widget/Toast/ToastSuccess.dart';
import 'package:carrent/core/ApiEndPoint.dart';
import 'package:http/http.dart' as http;
import 'package:carrent/model/User/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<User> fetchUserProfile(String id) async {
    try {
      final response = await http
          .get(Uri.parse('${ApiEndpoints.apiUrl}/api/user/profile/$id'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        User userDetails = User.fromJson(jsonData);
        return userDetails;
      } else {
        showToast('Failed to get your profile');
        throw Exception('Failed to load data.');
      }
    } catch (e) {
      showToast('Server Error');
      throw Exception('Server Error $e');
    }
  }

  Future<bool> updateUserProfile(
      String firstName, String lastName, String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';
    String id = prefs.getString('userId') ?? "";

    try {
      final body = jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber
      });

      final response = await http.put(
          Uri.parse('${ApiEndpoints.apiUrl}/api/user/profile/$id'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: body);

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showSucessToast('Profile updated successfully');
        return true;
      } else if (response.statusCode == 400) {
        showToast(responseBody['message']);
        return false;
      } else {
        showToast(responseBody['message']);
        return false;
      }
    } catch (e) {
      showToast('Something went wrong, check you connection');
      return false;
    }
  }
}
