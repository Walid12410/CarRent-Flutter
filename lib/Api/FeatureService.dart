import 'dart:convert';
import 'package:carrent/core/ApiEndPoint.dart';
import 'package:carrent/model/Feature/FeatureModel.dart';
import 'package:http/http.dart' as http;

class FeatureService {

  Future<List<Feature>> fetchFeature(int currentPage,String currentTime) async {
    try {
      final response = await http.get(Uri.parse('${ApiEndpoints.apiUrl}/api/feature?pageNumber=$currentPage&limitPage=5&currentTime=$currentTime'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Feature> featureList = jsonData.map((json) => Feature.fromJson(json)).toList();
        return featureList;
      } else {
        throw Exception('Failed to load feature');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

}