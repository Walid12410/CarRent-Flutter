import 'package:carrent/Authentication/LogIn/LogInPage.dart';
import 'package:carrent/Authentication/Register/SignUpPage.dart';
import 'package:carrent/OnBoardingPage/PageView.dart';
import 'package:carrent/navBar/NavBar.dart';
import 'package:carrent/provider/Car_Provider.dart';
import 'package:carrent/provider/Company_Provider.dart';
import 'package:carrent/provider/Offer_Provider.dart';
import 'package:carrent/provider/Promo_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PromoProvider()),
      ChangeNotifierProvider(create: (_) => CarProvider()),
      ChangeNotifierProvider(create: (_) => CompanyProvider()),
      ChangeNotifierProvider(create: (_) => OfferProvider()),
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
      child: MaterialApp(
        title: 'Car Rent',
        debugShowCheckedModeBanner: false,
        home: const NavBar(),
        routes: {
          "/LogIn": (context) => const LogInPage(),
          "/SignUp": (context) => const SignUpPage(),
          "/NavBar": (context) => const NavBar()
        },
      ),
    );
  }
}
