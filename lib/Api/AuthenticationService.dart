import 'dart:convert';
import 'package:carrent/Widget/ToastError.dart';
import 'package:http/http.dart' as http;
import '../core/ApiEndPoint.dart';

class Authentication {
  Future<bool> login(String email, String password) async {
    print('heloo');
    final url = Uri.parse('${ApiEndpoints.apiUrl}/api/auth/login');
    try {
      final body = jsonEncode({'email': email, 'password': password});

      final response = await http.post(url,
      headers: {'Content-Type': 'application/json'}, body: body);

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showToast('Success');
        return true;
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
