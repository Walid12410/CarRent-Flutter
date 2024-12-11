import 'package:carrent/Api/PromoService.dart';
import 'package:carrent/core/Time/CurrentTime.dart';
import 'package:carrent/model/Promo/GetPromoModel.dart';
import 'package:carrent/model/Promo/PromoDetailsModel.dart';
import 'package:carrent/model/Promo/PromoModel.dart';
import 'package:flutter/foundation.dart';

class PromoProvider with ChangeNotifier {
  PromoService promo = PromoService();

  List<Promo> _latestPromo = [];
  List<Promo> get latestPromo => _latestPromo;
  getLatestPromo(int pageNumber , String time , int limitPage) async {
    final res = await promo.fetchPromo(pageNumber, time, limitPage);
    _latestPromo = res;
    notifyListeners();
  }

  PromoDetails? _promoDetails;
  PromoDetails? get promoDetails => _promoDetails;
  getPromoDetails(String promoId) async {    
    final res = await promo.fetchOnePromo(promoId);
    _promoDetails = res;
    notifyListeners();
  }

  // get user promo
  List<GetPromo> _userPromo = [];
  List<GetPromo> get userPromo => _userPromo;
  getUserPromo() async {
    final res = await promo.fetchUserPromo();
    _userPromo = res;
    notifyListeners();  
  }

  // promo pagination
  final List<Promo> _promos = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _perPage = 4;
  bool _hasMoreData = true;

  List<Promo> get promos => _promos;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;

  Future<void> fetchPromos() async {
    String currentTime = getCurrentTimeInISO();


    if(_isLoading || !_hasMoreData) return;
    _isLoading = true;
    notifyListeners();

    try {
      List<Promo> newPromos = await promo.fetchPromo(_currentPage, currentTime, 4);
      if(newPromos.length < _perPage){
        _hasMoreData = false;
      } else{
        _currentPage++;
      }

      _promos.addAll(newPromos);
    } catch (e) {
      throw Exception(e);
    } finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetPromos(){
    _promos.clear();
    _currentPage = 1;
    _hasMoreData = true;
    notifyListeners();
  }
}
