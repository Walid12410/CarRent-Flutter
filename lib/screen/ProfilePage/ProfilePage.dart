import 'package:carrent/core/Color/color.dart';
import 'package:carrent/provider/User_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Details/LogOutBottom.dart';
import 'Details/ProfileCard.dart';
import 'Details/ProfilePageCard.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId') ?? ""; // Get userId from SharedPreferences
    if (userId.isEmpty) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/logIn'); // Redirect to login
      });
      return; // Prevent further execution
    }
    // ignore: use_build_context_synchronously
    final user = Provider.of<UserProvider>(context, listen: false);
    await user.getUserDetails(userId); // Fetch user details asynchronously
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: FutureBuilder<void>(
          future:
              _fetchDataFuture, 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: tdBlack,
              )); 
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something went wrong, check your connection',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: tdGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ); 
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20).w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: tdBlueLight),
                    ),
                    SizedBox(height: 20.h),
                    const ProfileCard(),
                    SizedBox(height: 20.h),
                    const ProfilePageCard(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15,left: 8,right: 8).w,
        child: BottomAppBar(
          surfaceTintColor: tdWhite,
          color: tdWhite,
          height: 55.h,
          child: const LogOutBottom(),
        ),
      ),
    );
  }
}
