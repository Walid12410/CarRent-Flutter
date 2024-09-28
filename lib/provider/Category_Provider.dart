import 'package:carrent/Api/CategoryService.dart';
import 'package:carrent/model/Category/CategoryModel.dart';
import 'package:flutter/cupertino.dart';


class CategoryProvider with ChangeNotifier {

  CategoryService category = CategoryService();

  List<Category> _allCategory = [];
  List<Category> get allCategory => _allCategory;
  getAllCategory() async {
    final res = await category.fetchCategory();
    _allCategory = res;
    notifyListeners();
  }

}