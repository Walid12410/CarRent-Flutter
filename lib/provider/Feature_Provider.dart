import 'package:carrent/Api/FeatureService.dart';
import 'package:carrent/Time/CurrentTime.dart';
import 'package:flutter/material.dart';
import 'package:carrent/model/Feature/FeatureModel.dart';

class FeatureProvider with ChangeNotifier {
  final List<Feature> _features = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _perPage = 5; 
  bool _hasMoreData = true;

  List<Feature> get features => _features;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;

  final FeatureService _featureService = FeatureService(); 

  Future<void> fetchFeatures() async {
    String currentTime = getCurrentTimeInISO();

    if (_isLoading || !_hasMoreData) return;
    _isLoading = true;
    notifyListeners();

    try {

      List<Feature> newFeatures = await _featureService.fetchFeature(_currentPage,currentTime);

      if (newFeatures.length < _perPage) {
        _hasMoreData = false; 
      } else {
        _currentPage++;
      }
      _features.addAll(newFeatures);
      notifyListeners();
    } catch (error) {
      throw Exception(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetFeatures() {
    _features.clear();
    _currentPage = 1;
    _hasMoreData = true;
    notifyListeners();
  }
}
