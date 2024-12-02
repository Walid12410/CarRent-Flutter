import 'dart:convert';
import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/Widget/Toast/ToastSuccess.dart';
import 'package:carrent/Widget/Toast/ToastValidation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/ApiEndPoint.dart';

class Authentication {
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('${ApiEndpoints.apiUrl}/api/auth/login');
    try {
      final body = jsonEncode({'email': email, 'password': password});

      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);

      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Save user data locally using sharedPreferences library
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userId',responseBody['_id']);
        prefs.setString('userToken',responseBody['token']);
        prefs.setBool('isLoggedIn', true);
        // login success
        showSucessToast('Success');
        return true;
      } else {
        // falid to login . send error message
        showValidationToast(responseBody['message']);
        return false;
      }
    } catch (e) {
      showToast('Something went wrong, check you connection');
      print(e);
      return false;
    }
  }

  Future<bool> signup(String firstName, String lastName, String phoneNumber,
      String email, String password) async {
    final url = Uri.parse('${ApiEndpoints.apiUrl}/api/auth/register');
    try {
      final body = jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password
      });

      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        showSucessToast('Success');
        return true;
      } else {
        showValidationToast(responseBody['message']);
        return false;
      }
    } catch (e) {
      showToast('Something went wrong, check you connection');
      return false;
    }
  }
}
