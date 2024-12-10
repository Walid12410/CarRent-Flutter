import 'package:carrent/Api/BookingService.dart';
import 'package:carrent/model/Booking/BookingModel.dart';
import 'package:flutter/cupertino.dart';

class BookingProvider with ChangeNotifier {
  BookingService service = BookingService();

  // fetch all user booking
  List<Booking> _allUserBooking = [];
  List<Booking> get allUserBooking => _allUserBooking;
  getAllUserBooking() async {
    final res = await service.fetchUserBooking();
    _allUserBooking = res;
    notifyListeners();
  }

}
