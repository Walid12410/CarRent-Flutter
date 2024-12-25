import 'package:carrent/Api/NotificationService.dart';
import 'package:carrent/model/Notification/NotificationModel.dart';
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  NotificationService service = NotificationService();

  // user notification pagination
  final List<NotificationModel> _userNotification = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _perPage = 10;
  bool _hasMoreData = true;

  List<NotificationModel> get userNotification => _userNotification;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;

  Future<void> getUserNotification() async {
    if (_isLoading || !_hasMoreData) return;
    _isLoading = true;
    notifyListeners();

    try {
      List<NotificationModel> newNotification =
          await service.fetchAllUserNotification(_currentPage, 10);
      if (newNotification.length < _perPage) {
        _hasMoreData = false;
      } else {
        _currentPage++;
      }
      for (var notification in newNotification) {
        if (!_userNotification.any((existingNotification) => existingNotification.id == notification.id)) {
          _userNotification.add(notification);
        }
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetUserNotification() {
    _userNotification.clear();
    notifyListeners();
  }

}