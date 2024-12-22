import 'dart:convert';
import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/Widget/Toast/ToastSuccess.dart';
import 'package:carrent/core/ApiEndPoint.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:http/http.dart' as http;
import 'package:carrent/model/User/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<User> fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? "";
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

  Future<bool> updatePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';
    String id = prefs.getString('userId') ?? "";

    try {
      final body = jsonEncode({
        'password': password,
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
        showSucessToast('Password updated Successfully');
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

  Future<bool> updateLocation(
      double latitude, double longitude, String locationName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';
    String id = prefs.getString('userId') ?? "";

    try {
      final body = jsonEncode({
        'latitude': latitude,
        'longitude': longitude,
        'locationName': locationName
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
        showSucessToast('Location save');
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

  Future<void> uploadProfileImage(File image) async {
    final url = Uri.parse(
        "${ApiEndpoints.apiUrl}/api/user/profile/upload-image"); // Replace with your API URL
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';

    try {
      var request = http.MultipartRequest("POST", url)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath('image', image.path));

      var response = await request.send();

      // Check if the response was successful
      if (response.statusCode == 200) {
        // Decode the response body to get the result (if needed)
        final responseData = json.decode(await response.stream.bytesToString());
        print("Success: ${responseData['message']}");

        // Optionally, update user profile with the new photo URL from response
      } else {
        // Handle failure response
        final responseData = json.decode(await response.stream.bytesToString());
        throw Exception("Failed to upload image: ${responseData['message']}");
      }
    } catch (error) {
      print("Error uploading image: $error");
      rethrow; // Optionally handle rethrow or show an error to the user
    }
  }
}
