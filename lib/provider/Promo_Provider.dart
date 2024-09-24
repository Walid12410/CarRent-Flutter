import 'package:carrent/Api/PromoService.dart';
import 'package:carrent/model/Promo/PromoModel.dart';
import 'package:flutter/foundation.dart';


class PromoProvider with ChangeNotifier {
  PromoService promo = PromoService();

  List<Promo> _latestPromo = [];
  List<Promo> get latestPromo => _latestPromo;
  getLatestPromo() async {
    final res = await promo.fetchLatestPromo(1);
    _latestPromo = res;
    notifyListeners();
  }


}