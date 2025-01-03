import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrent/Api/BookingService.dart';
import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/Widget/Toast/ToastValidation.dart';
import 'package:carrent/core/Color/color.dart';
import 'package:carrent/core/Time/CurrentTime.dart';
import 'package:carrent/model/CarDetails/CarDetailsModel.dart';
import 'package:carrent/model/Promo/GetPromoModel.dart';
import 'package:carrent/provider/Offer_Provider.dart';
import 'package:carrent/provider/Promo_Provider.dart';
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
  late Future<void> _fetchDataFuture;
  DateTime? startDate;
  DateTime? endDate;
  TextEditingController promoCodeController = TextEditingController();
  GetPromo? validPromo;
  double finalPrice = 0.0;
  int perentageSale = 0;
  String promoCodeText = "Use a discount code";
  bool validPromoCode = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
    final offer = Provider.of<OfferProvider>(context, listen: false);
    var isOffer = offer.carOffer;

    if (isOffer.isNotEmpty) {
      finalPrice = double.parse(isOffer.first.discountPrice);
    } else {
      finalPrice = widget.car.rentPrice;
    }
  }

  Future<void> _fetchData() async {
    final offer = Provider.of<OfferProvider>(context, listen: false);
    final promo = Provider.of<PromoProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    String currentTime = getCurrentTimeInISO();
    await offer.getCarOffer(currentTime, widget.car.id);
    await promo.getUserPromo();
    await user.getUserDetails();
  }

  // Function to show the date range picker dialog
  Future<void> pickerDateRange() async {
    final offer = Provider.of<OfferProvider>(context, listen: false);
    var isOffer = offer.carOffer;

    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: startDate ?? DateTime.now(),
        end: endDate ?? DateTime.now().add(const Duration(days: 30)),
      ),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: tdBlueLight, // Selection handle and range color
              onPrimary: tdWhite, // Text color for selected date
            ),
          ),
          child: child!,
        );
      },
    );

    if (isOffer.isNotEmpty) {
      finalPrice = double.parse(isOffer.first.discountPrice);
    } else {
      finalPrice = widget.car.rentPrice;
    }

    if (newDateRange != null) {
      setState(() {
        startDate = newDateRange.start;
        endDate = newDateRange.end;
        int days = calculateTotalDays();
        finalPrice = days * finalPrice;
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

  void checkAndSavePromo(String promoCode, List<GetPromo> userPromo) {
    if (promoCode.isEmpty || promoCode == "") {
      showToast('Enter a promo code');
      return;
    }

    final offer = Provider.of<OfferProvider>(context, listen: false);
    var isOffer = offer.carOffer;

    if (isOffer.isNotEmpty) {
      finalPrice = double.parse(isOffer.first.discountPrice);
    } else {
      finalPrice = widget.car.rentPrice;
    }

    // Search for the promo by promoCode and check if it's unused
    for (var promo in userPromo) {
      if (promo.promoDetails!.promoCode == promoCode && !promo.isUsed) {
        validPromo = promo;
        break;
      }
    }

    if (validPromo != null) {
      if (validPromo!.promoDetails!.companyID != widget.car.companyId) {
        showToast('This promo code is not applicable to this company car');
      } else {
        setState(() {
          validPromoCode = true;
          promoCodeText = promoCode;
          perentageSale = validPromo!.promoDetails!.discountPercentage;
          finalPrice = finalPrice - (finalPrice * (perentageSale / 100));
        });
      }
    } else {
      showToast('No valid promo found for the provided promoCode');
    }
  }

  void _showPromoCodeDialog() {
    final promo = Provider.of<PromoProvider>(context, listen: false);
    var userPromo = promo.userPromo;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: tdWhite,
          surfaceTintColor: tdWhite,
          title: Text(
            "Enter you promo code",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: tdBlueLight),
          ),
          content: TextField(
            controller: promoCodeController,
            cursorColor: tdBlueLight,
            decoration: InputDecoration(
              hintText: "Promo code",
              hintStyle: TextStyle(color: tdGrey, fontSize: 10.sp),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: tdGrey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: tdBlueLight),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: tdBlueLight),
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    checkAndSavePromo(promoCodeController.text, userPromo);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 100.w,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: tdBlueLight,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Apply",
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: tdWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 100.w,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: tdWhite,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: tdBlueLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void submitHandler() async {
    BookingService service = BookingService();

    if (startDate == null) {
      return showValidationToast('Select a date range');
    }

    if (endDate == null) {
      return showValidationToast('Select a date range');
    }
    String startDateIso = '', endDateIso = '';

    if (startDate != null && endDate != null) {
      startDateIso = startDate!.toIso8601String(); // Convert to ISO 8601 string
      endDateIso = endDate!.toIso8601String();
    }

    try {
      setState(() {
        isLoading = true;
      });
      bool success = await service.createNewBooking(
          widget.car.id,
          calculateTotalDays(),
          finalPrice.toString(),
          widget.car.rentPrice,
          perentageSale,
          validPromoCode ? promoCodeController.text : null,
          startDateIso,
          endDateIso);
      if (success) {
        setState(() {
          context.go(context.namedLocation('ThankYou'));
        });
      }
    } catch (e) {
      showToast('Something went wrong');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true);
    final offer = Provider.of<OfferProvider>(context, listen: true);
    var userDetails = user.userDetails;
    var isOffer = offer.carOffer;

    if (userDetails == null) {
      return Center(
        child: Text(
          'Something went wrong, try again later.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
            color: tdGrey,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
          child: FutureBuilder(
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
          } else {
            return SingleChildScrollView(
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
                      onTap: () {
                        pickerDateRange();
                      },
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
                      _buildDateInfo(
                          'Total Days', calculateTotalDays().toString()),
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
                        _showPromoCodeDialog();
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: tdGrey),
                            borderRadius: BorderRadius.circular(12).w,
                            color: tdWhite),
                        child: Padding(
                          padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 10)
                              .w,
                          child: Text(
                            promoCodeText,
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
            );
          }
        },
      )),
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
              if (isOffer.isEmpty) ...[
                _buildPriceInfo(
                    widget.car.rentPrice, perentageSale, finalPrice),
              ] else ...[
                _buildPriceInfo(double.parse(isOffer.first.discountPrice),
                    perentageSale, finalPrice),
              ],
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: isLoading
                    ? null
                    : () {
                        submitHandler();
                      },
                child: Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12).w,
                      color: tdBlueLight),
                  child: Center(
                      child: Text(
                    isLoading ? "Loading..." : 'Payment',
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
    final offer = Provider.of<OfferProvider>(context, listen: true);
    var isOffer = offer.carOffer;

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
            if (isOffer.isEmpty) ...[
              Text(
                "\$${widget.car.rentPrice} / day",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: tdBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ] else ...[
              Row(
                children: [
                  Text(
                    '\$${widget.car.rentPrice} / day',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: tdBlue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 3,
                      decorationColor: tdGrey,
                    ),
                  ),
                  Text(
                    '   \$${isOffer.first.discountPrice}/ day',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
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

  Widget _buildPriceInfo(double carPrice, int perent, double finalPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RenterInfoLabel(label: 'Main price'),
            const RenterInfoLabel(label: 'Discount percent'),
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
              '$perentageSale %',
              style: _renterInfoStyle(),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              '\$$finalPrice',
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
