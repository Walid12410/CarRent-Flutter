import 'package:carrent/Api/FeatureService.dart';
import 'package:carrent/core/Time/CurrentTime.dart';
import 'package:flutter/material.dart';
import 'package:carrent/model/Feature/FeatureModel.dart';

class FeatureProvider extends ChangeNotifier {
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

    if (_isLoading || !_hasMoreData) return; // Avoid unnecessary calls
    _isLoading = true;
    notifyListeners(); // Notify only once to show the loading spinner

    try {
      // Fetch new data from the service
      List<Feature> newFeatures = await _featureService.fetchFeature(_currentPage, currentTime);

      // Check if we have less data than expected to stop loading
      if (newFeatures.length < _perPage) {
        _hasMoreData = false;
      } else {
        _currentPage++; // Increment page for next batch
      }

      // Append new features to the existing list
      _features.addAll(newFeatures);
    } catch (error) {
      throw Exception(error);
    } finally {
      _isLoading = false; // Mark loading as false once done
      notifyListeners(); // Only one notifyListeners after all operations
    }
  }

  // Reset features and reload
  void resetFeatures() {
    _features.clear();
    _currentPage = 1;
    _hasMoreData = true;
    notifyListeners();
  }
}
