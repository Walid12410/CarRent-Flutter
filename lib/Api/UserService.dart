import 'dart:convert';

import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/core/ApiEndPoint.dart';
import 'package:http/http.dart' as http;
import 'package:carrent/model/User/UserModel.dart';

class UserService {

  
  Future<User> fetchUserProfile(String id) async {
    try {
      final response = await http.get(Uri.parse('${ApiEndpoints.apiUrl}/api/user/profile/$id'));
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
}