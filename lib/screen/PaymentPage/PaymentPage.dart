import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrent/core/Color/color.dart';
import 'package:carrent/model/CarDetails/CarDetailsModel.dart';
import 'package:carrent/provider/User_Provider.dart';
import 'package:carrent/screen/PaymentPage/Details/RentalInfoLable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.car});

  final CarDetails car;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  DateTime? startDate;
  DateTime? endDate;

  /// Opens the date picker to select the end date.
  void pickEndDate() async {
    final DateTime today = DateTime.now();
    final DateTime oneYearLater = today.add(const Duration(days: 365));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: today.add(const Duration(days: 1)),
      firstDate: today.add(const Duration(days: 1)),
      lastDate: oneYearLater,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: tdBlueLight,
            scaffoldBackgroundColor: tdBlack,
            dialogBackgroundColor: tdBlack,
            textTheme: const TextTheme(
              headline6: TextStyle(color: tdBlueLight), // Header text color
              bodyText2:
                  TextStyle(color: tdBlueLight), // Calendar date text color
            ),
            colorScheme: const ColorScheme.light(
              primary: tdBlueLight,
              onPrimary: tdBlack,
              onSurface: tdBlueLight,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: tdBlueLight, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        startDate = today;
        endDate = selectedDate;
      });
    }
  }

  /// Calculates the total rental days.
  int calculateTotalDays() {
    if (startDate != null && endDate != null) {
      return endDate!.difference(startDate!).inDays + 1; // Include the last day
    }
    return 0;
  }

  /// Formats a date into a readable string without time.
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true);
    var userDetails = user.userDetails;

    if (userDetails == null) {
      return Container();
    }

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                _buildBackButton(context),
                SizedBox(height: 10.h),
                _buildSectionTitle('Checkout'),
                SizedBox(height: 15.h),
                _buildSectionTitle('CAR DETAIL', small: true),
                SizedBox(height: 10.h),
                _buildCarDetails(),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: pickEndDate,
                  child: Text(
                    'Select Rental Dates',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (startDate != null && endDate != null) ...[
                  SizedBox(height: 5.h),
                  _buildDateInfo('Start Date', formatDate(startDate!)),
                  _buildDateInfo('End Date', formatDate(endDate!)),
                  _buildDateInfo('Total Days', calculateTotalDays().toString()),
                ],
                SizedBox(height: 15.h),
                _buildSectionTitle('RENTER INFORMATION', small: true),
                SizedBox(height: 10.h),
                _buildRenterInfo(userDetails),
                SizedBox(
                  height: 15.h,
                ),
                _buildSectionTitle('DISCOUNT', small: true),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () {
                    // @TODO call dialog to check promo code
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: tdGrey),
                        borderRadius: BorderRadius.circular(12).w,
                        color: tdWhite),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 10)
                              .w,
                      child: Text(
                        'Use a discount code',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: tdBlueLight,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: tdWhite,
        color: tdWhite,
        height: 170.h,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10).w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              _buildSectionTitle('PRICE DETAILS', small: true),
              SizedBox(
                height: 10.h,
              ),
              _buildPriceInfo(widget.car.rentPrice, 3),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  // @TODO payment
                },
                child: Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12).w,
                      color: tdBlueLight),
                  child: Center(
                      child: Text(
                    'Payment',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: tdWhite,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      onPressed: () => context.pop(),
      icon: Icon(
        Icons.arrow_back_ios,
        size: 20.w,
        color: tdGrey,
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool small = false}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: small ? 10.sp : 18.sp,
        color: tdBlueLight,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCarDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.car.carMake.carMakeName} ${widget.car.carModel} - ${widget.car.year}',
              style: TextStyle(
                fontSize: 12.sp,
                color: tdBlueLight,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              "\$${widget.car.rentPrice} / day",
              style: TextStyle(
                fontSize: 12.sp,
                color: tdBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 60.h,
          width: 80.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12).w,
            child: CachedNetworkImage(
              imageUrl: widget.car.carImage[0].carImage.url,
              fit: BoxFit.fill,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
                color: tdBlueLight,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateInfo(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Text(
        '$label: $value',
        style: TextStyle(
          fontSize: 10.sp,
          color: tdBlueLight,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPriceInfo(double carPrice, double deliveryPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RenterInfoLabel(label: 'Trip price'),
            const RenterInfoLabel(label: 'Delivery price'),
            Text(
              'Total',
              style: TextStyle(
                  fontSize: 14.sp,
                  color: tdBlueLight,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$$carPrice',
              style: _renterInfoStyle(),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              '\$$deliveryPrice',
              style: _renterInfoStyle(),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              '\$${deliveryPrice + carPrice}',
              style: _renterInfoStyle(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRenterInfo(userDetails) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RenterInfoLabel(label: 'Full name'),
            RenterInfoLabel(label: 'Address Line'),
            RenterInfoLabel(label: 'Phone number')
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${userDetails.firstName} ${userDetails.lastName}',
              style: _renterInfoStyle(),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              userDetails.locationName,
              style: _renterInfoStyle(),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              userDetails.phoneNumber,
              style: _renterInfoStyle(),
            ),
          ],
        ),
      ],
    );
  }

  TextStyle _renterInfoStyle() {
    return TextStyle(
      fontSize: 10.sp,
      color: tdBlueLight,
      fontWeight: FontWeight.bold,
    );
  }
}
