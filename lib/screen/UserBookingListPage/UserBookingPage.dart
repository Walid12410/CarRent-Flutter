import "package:carrent/Widget/Car/BookingCarCard.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/provider/Booking_Provider.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

class UserBookingListPage extends StatefulWidget {
  const UserBookingListPage({super.key});

  @override
  State<UserBookingListPage> createState() => _UserBookingListPageState();
}

class _UserBookingListPageState extends State<UserBookingListPage> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    final booking = Provider.of<BookingProvider>(context, listen: false);
    await booking.getAllUserBooking();
  }

  @override
  Widget build(BuildContext context) {
    final booking = Provider.of<BookingProvider>(context, listen: true);
    var userBooking = booking.allUserBooking;

    return Scaffold(
        backgroundColor: tdWhite,
        appBar: AppBar(
          title: Text(
            'My Booking',
            style: TextStyle(
                fontSize: 15.sp,
                color: tdBlueLight,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: tdWhite,
          shadowColor: tdWhite,
          surfaceTintColor: tdWhite,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20).w,
            child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20.w,
                  color: tdGrey,
                )),
          ),
        ),
        body: FutureBuilder(
            future: _fetchDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: tdBlack,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Something went wrong, check your connection.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: tdGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }else if(userBooking.isEmpty) {
                return Center(
                  child: Text(
                    'No car rented yet.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: tdGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: userBooking.length,
                    itemBuilder: (context, index) {
                      final book = userBooking[index];
                      return BookingCarCard(book: book);
                    });
              }
            }));
  }
}
