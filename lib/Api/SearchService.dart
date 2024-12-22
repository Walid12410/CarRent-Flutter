import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/core/ApiEndPoint.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SearchService {

  Future<void> fetchSearch(int pageNumber , String searchQuery, List<String>?
  categories , String minPrice, String maxPrice ,String? carMake ) async {
    final url = Uri.parse('${ApiEndpoints.apiUrl}/api/car-rent/search');

    try {
      final body = jsonEncode({
        'pageNumber' : pageNumber,
        'limit' : 10,
        'searchQuery' : searchQuery,
        if(categories != null) 'categoryId' : categories,
        'priceMin' : minPrice,
        'priceMax' : maxPrice,
        if(carMake != null) 'carMakeId' : carMake,
        'carModel' : searchQuery
      });

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body
      );


    } catch (e) {
      showToast('Server Error');
      throw Exception('Server Error $e');
    }
  }
}