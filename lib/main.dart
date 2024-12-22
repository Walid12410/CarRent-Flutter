import 'package:carrent/provider/Booking_Provider.dart';
import 'package:carrent/provider/Car_Provider.dart';
import 'package:carrent/provider/Category_Provider.dart';
import 'package:carrent/provider/Company_Provider.dart';
import 'package:carrent/provider/Feature_Provider.dart';
import 'package:carrent/provider/Offer_Provider.dart';
import 'package:carrent/provider/Promo_Provider.dart';
import 'package:carrent/provider/Review_Provider.dart';
import 'package:carrent/provider/Search_Provider.dart';
import 'package:carrent/provider/User_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/Route/GoRouter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Fetch isLoggedIn status
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Set the initial route based on the login status
  AppNavigation.setInitialRoute(isLoggedIn);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PromoProvider()),
      ChangeNotifierProvider(create: (_) => CarProvider()),
      ChangeNotifierProvider(create: (_) => CompanyProvider()),
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => OfferProvider()),
      ChangeNotifierProvider(create: (_) => FeatureProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => BookingProvider()),
      ChangeNotifierProvider(create: (_) => SerachProvider()),
      ChangeNotifierProvider(create: (_) => ReviewProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        title: 'Car Rent',
        debugShowCheckedModeBanner: false,
        routerConfig: AppNavigation.router,
      ),
    );
  }
}
