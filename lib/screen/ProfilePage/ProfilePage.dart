import 'package:carrent/core/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Details/LogOutBottom.dart';
import 'Details/ProfileCard.dart';
import 'Details/ProfilePageCard.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20).w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h,),
                Text('Profile',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,color: tdBlueLight),),
                SizedBox(height: 20.h,),
                const ProfileCard(),
                SizedBox(height: 20.h,),
                const ProfilePageCard()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15).w,
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



