import 'package:carrent/Api/CompanyService.dart';
import 'package:carrent/model/Company/CompanyModel.dart';
import 'package:flutter/foundation.dart';


class CompanyProvider with ChangeNotifier {
  CompanyService company = CompanyService();

  List<Company> _latestCompany = [];
  List<Company> get latestCompany => _latestCompany;
  getLastCompany() async {
    final res = await company.fetchLatestCompany();
    _latestCompany = res;
    notifyListeners();
  }


}