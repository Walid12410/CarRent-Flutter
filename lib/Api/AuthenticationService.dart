import 'dart:convert';
import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/Widget/Toast/ToastSuccess.dart';
import 'package:carrent/Widget/Toast/ToastValidation.dart';
import 'package:http/http.dart' as http;
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
        // @TODO save the user data in shareprefrence
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
