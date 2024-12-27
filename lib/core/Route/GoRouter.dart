import 'package:carrent/model/Car/CarModel.dart';
import 'package:carrent/model/CarDetails/CarDetailsModel.dart';
import 'package:carrent/model/Company/CompanyModel.dart';
import 'package:carrent/screen/AuthenticationPages/LogIn/LogInPage.dart';
import 'package:carrent/screen/AuthenticationPages/Register/SignUpPage.dart';
import 'package:carrent/screen/CarCategoryListPage/CarCategoryListPage.dart';
import 'package:carrent/screen/CarCategoryPage/CategoryPage.dart';
import 'package:carrent/screen/CarDetailsPage/CarDetailsPage.dart';
import 'package:carrent/screen/CarReviewListPage/CarReviewListPage.dart';
import 'package:carrent/screen/ChangePasswordPage/ChangePasswordPage.dart';
import 'package:carrent/screen/CompanyCarListPage/CompanyCarList.dart';
import 'package:carrent/screen/CompanyDetailMorePage/CompanyMoreDetailsPage.dart';
import 'package:carrent/screen/CompanyDetailsPage/CompanyDetailsPage.dart';
import 'package:carrent/screen/CompanyListPage/CompanyListPage.dart';
import 'package:carrent/screen/HomePage/HomePage.dart';
import 'package:carrent/screen/LatestCarPageList/LatestCarPage.dart';
import 'package:carrent/screen/LimitedOfferPage/LimitedOfferPage.dart';
import 'package:carrent/screen/MapPage/MapPage.dart';
import 'package:carrent/screen/NotificationPage/NotificationPage.dart';
import 'package:carrent/screen/OnBoardingPage/PageView.dart';
import 'package:carrent/screen/PaymentPage/PaymentPage.dart';
import 'package:carrent/screen/ProfilePage/ProfilePage.dart';
import 'package:carrent/screen/PromotionDetailsPage/PromotionDetailsPage.dart';
import 'package:carrent/screen/PromotionPage/PromotionPage.dart';
import 'package:carrent/screen/RentWayPage/RentWayPage.dart';
import 'package:carrent/core/NavigationButton/NavBar.dart';
import 'package:carrent/screen/ReviewMakePage/AddReview.dart';
import 'package:carrent/screen/SearchPage/SearchPage.dart';
import 'package:carrent/screen/UpdateProfilePage/UpdateProfilePage.dart';
import 'package:carrent/screen/UpdateReviewPage/UpdateReviewPage.dart';
import 'package:carrent/screen/UserBookingListPage/UserBookingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  AppNavigation._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorCategory =
      GlobalKey<NavigatorState>(debugLabel: 'shellCategory');
  static final _shellNavigatorRentWay =
      GlobalKey<NavigatorState>(debugLabel: 'shellRentWay');
  static final _shellNavigatorProfile =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
  static final _shellNavigatorCoupons =
      GlobalKey<NavigatorState>(debugLabel: 'shellCoupons');

  static String initial = "/onBoarding"; // Default to Onboarding initially.
  // Set the initial route based on isLoggedIn passed from main()
  static void setInitialRoute(bool isLoggedIn) {
    initial = isLoggedIn ? "/home" : "/onBoarding";
  }

  static final GoRouter router = GoRouter(
    initialLocation: initial,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavBar(
            navigationShell: navigationShell,
            router: router,
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                  path: "/home",
                  name: "Home",
                  builder: (BuildContext context, GoRouterState state) =>
                      const HomePage(),
                  routes: [
                    GoRoute(
                      path: 'LimitedOffer',
                      name: 'LimitedOffer',
                      pageBuilder: (context, state) =>
                          CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const LimitedOfferPage(),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ),
                    ),
                    GoRoute(
                      path: 'CompanyList',
                      name: 'CompanyList',
                      pageBuilder: (context, state) =>
                          CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const CompanyListPage(),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ),
                    ),
                    GoRoute(
                      path: 'CompanyDetails/:id',
                      name: 'CompanyDetails',
                      pageBuilder: (context, state) =>
                          CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: CompanyDetailsPage(
                          companyId: state.pathParameters['id']!,
                        ),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ),
                    ),
                    GoRoute(
                      path: 'LatestCar',
                      name: 'LatestCar',
                      pageBuilder: (context, state) =>
                          CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const LatestCarPage(),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ),
                    ),
                    GoRoute(
                      path: 'Notification',
                      name: 'Notification',
                      pageBuilder: (context, state) =>
                          CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const NotificationPage(),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ),
                    ),
                    GoRoute(
                      path: 'Search',
                      name: 'Search',
                      pageBuilder: (context, state) =>
                          CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const SearchPage(),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ),
                    ),
                    GoRoute(
                      path: 'GoogleMap',
                      name: 'GoogleMap',
                      pageBuilder: (context, state) =>
                          CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const GoogleMapScreen(),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ),
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCategory,
            routes: <RouteBase>[
              GoRoute(
                path: "/category",
                name: "Category",
                builder: (BuildContext context, GoRouterState state) =>
                    const CarCategoryPage(),
                routes: [
                  GoRoute(
                    path: 'CarCategoryList/:id',
                    name: 'CarCategoryList',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: CarCategoryListPage(
                        categoryId: state.pathParameters['id']!,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorRentWay,
            routes: <RouteBase>[
              GoRoute(
                path: "/rentWay",
                name: "RentWay",
                builder: (BuildContext context, GoRouterState state) =>
                    const RentWayPage(),
                // routes: [
                // ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfile,
            routes: <RouteBase>[
              GoRoute(
                path: "/profile",
                name: "Profile",
                builder: (BuildContext context, GoRouterState state) =>
                    const ProfilePage(),
                routes: [
                  GoRoute(
                    path: 'ProfileUpdate',
                    name: 'ProfileUpdate',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const UpdateProfilePage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'PasswordUpdate',
                    name: 'PasswordUpdate',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const ChangePasswordPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'UserBookingList',
                    name: 'UserBookingList',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const UserBookingListPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCoupons,
            routes: <RouteBase>[
              GoRoute(
                path: "/coupons",
                name: "Coupons",
                builder: (BuildContext context, GoRouterState state) =>
                    const PromotionPage(),
                // routes: [
                // ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/logIn',
        name: "LogIn",
        builder: (context, state) => LogInPage(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: '/companydetils/:id', // Using path parameters for dynamic content
        name: 'companydetils',
        builder: (context, state) {
          final companyId = state.pathParameters['id']!;
          return CompanyDetailsPage(companyId: companyId);
        },
      ),
      GoRoute(
        path:
            '/CompanyCarDetails/:id', // Using path parameters for dynamic content
        name: 'CompanyCarDetails',
        builder: (context, state) {
          final companyId = state.pathParameters['id']!;
          return CompanyCarList(companyId: companyId);
        },
      ),
      GoRoute(
        path: '/CarReviewList/:id', // Using path parameters for dynamic content
        name: 'CarReviewList',
        builder: (context, state) {
          final carId = state.pathParameters['id']!;
          return CarReviewList(carId: carId);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/signUp',
        name: "SignUp",
        builder: (context, state) => SignUpPage(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/payment',
        name: "Payment",
        builder: (context, state) {
          // Extracting parameters from the `extra` property
          final extra = state.extra as Map<String, dynamic>;
          final CarDetails car = extra['car'] as CarDetails;

          return PaymentPage(
            key: state.pageKey,
            car: car,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/companyMoreDetails',
        name: "CompanyMoreDetails",
        builder: (context, state) => CompanyMoreDetails(
            key: state.pageKey,
          ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/onBoarding',
        name: "OnBoarding",
        builder: (context, state) => PageViewScreen(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/promoDetails/:id',
        name: "PromoDetails",
        builder: (context, state) => PromotionDetailsPage(
          key: state.pageKey,
          promoId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/carDetails/:id',
        name: "CarDetails",
        builder: (context, state) => CarDetailsPage(
          key: state.pageKey,
          carId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/addReview',
        name: "AddReview",
        builder: (context, state) {
          // Safely cast state.extra to Car
          final car = state.extra as Car?;
          // Check if car is null and handle appropriately
          if (car == null) {
            throw Exception("Car object is required for AddReviewPage");
          }
          return AddReviewPage(car: car);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/updateReview',
        name: "updateReview",
        builder: (context, state) {
          // Safely cast state.extra to Car
          final car = state.extra as Car?;
          // Check if car is null and handle appropriately
          if (car == null) {
            throw Exception("Car object is required for AddReviewPage");
          }
          return UpdateReviewPage(car: car);
        },
      ),
    ],
  );
}
