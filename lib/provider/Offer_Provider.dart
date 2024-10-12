import 'package:carrent/core/Time/CurrentTime.dart';
import 'package:carrent/model/Offer/OfferModel.dart';
import 'package:flutter/foundation.dart';
import '../Api/OfferService.dart';

class OfferProvider with ChangeNotifier {
  OfferService service = OfferService();
  
  // Top offer
  List<Offer> _topOffer = [];
  List<Offer> get topOffer => _topOffer;
  getTopOffer(String time) async {
    final res = await service.fetchTopOffer(time);
    _topOffer = res;
    notifyListeners();
  }

  // Limited Offer pagination
  final List<Offer> _offers = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _perPage = 5;
  bool _hasMoreData = true;

  List<Offer> get offers => _offers;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;

  Future<void> fetchOffers() async {
    String currentTime = getCurrentTimeInISO();

    if (_isLoading || !_hasMoreData) return;
    _isLoading = true;
    notifyListeners();

    try {
      List<Offer> newOffers =
          await service.fetchOffer(currentTime, _currentPage, 5);
      if (newOffers.length < _perPage) {
        _hasMoreData = false;
      } else {
        _currentPage++;
      }

      _offers.addAll(newOffers);
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetOffer() {
    _offers.clear();
    _currentPage = 1;
    _hasMoreData = true;
    notifyListeners();
  }
}
