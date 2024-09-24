import 'package:carrent/model/Offer/OfferModel.dart';
import 'package:flutter/foundation.dart';
import '../Api/OfferService.dart';


class OfferProvider with ChangeNotifier {
  OfferService offer = OfferService();

  List<Offer> _topOffer = [];
  List<Offer> get topOffer => _topOffer;
  getTopOffer(String time) async {
    final res = await offer.fetchTopOffer(time);
    _topOffer = res;
    notifyListeners();
  }


}