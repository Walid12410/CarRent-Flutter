import 'package:carrent/model/Category/CategoryModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../ApiEndPoint.dart';


class CategoryService {

  Future<List<Category>> fetchCategory() async {
    try {
      final response = await http.get(Uri.parse('${ApiEndpoints.apiUrl}/api/category'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Category> category = jsonData.map((json) => Category.fromJson(json)).toList();
        return category;
      } else {
        throw Exception('Failed to load category');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

}