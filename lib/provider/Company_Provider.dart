import 'package:carrent/Api/CompanyService.dart';
import 'package:carrent/model/Company/CompanyModel.dart';
import 'package:flutter/foundation.dart';

class CompanyProvider with ChangeNotifier {
  CompanyService service = CompanyService();

  List<Company> _latestCompany = [];
  List<Company> get latestCompany => _latestCompany;
  getLastCompany() async {
    final res = await service.fetchLatestCompany();
    _latestCompany = res;
    notifyListeners();
  }

  List<Company> _allCompanies = [];
  List<Company> get allCompanies => _allCompanies;
  getAllCompany() async {
    final res = await service.fetchAllCompany();
    _allCompanies = res;
    notifyListeners();
  }


  Company? _companyDetails;
  Company? get companyDetails => _companyDetails;
  getCompanyDetails(String companyId) async {
    final res = await service.fetchOneCompany(companyId);
    _companyDetails = res;
    notifyListeners();
  }
}
