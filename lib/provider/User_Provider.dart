import 'package:carrent/Api/UserService.dart';
import 'package:carrent/model/User/UserModel.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  UserService service = UserService();

  // user details
  User? _userDetails;
  User? get userDetails => _userDetails;
  getUserDetails() async {
    final res = await service.fetchUserProfile();
    _userDetails = res;
    notifyListeners();
  }

}
