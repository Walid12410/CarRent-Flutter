import 'package:carrent/core/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20).w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20.w,
                    )),
                SizedBox(height: 15.h),
                Text(
                  'Welcome to RentWay 👌',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: tdBlack),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Enter your RentWay account to continue',
                  style: TextStyle(fontSize: 12.sp, color: tdGrey),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Email address',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: tdBlack,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3.h),
                Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12).w,
                      border: Border.all(color: tdGrey)),
                  child: Padding(
                    padding: const EdgeInsets.all(5).w, // Add padding for text
                    child: TextField(
                      cursorColor: tdGrey,
                      decoration: InputDecoration(
                        border:
                            InputBorder.none, // Removes the default underline
                        hintText: 'Your email address', // Placeholder text
                        hintStyle: TextStyle(
                            color: tdGrey,
                            fontSize: 12.sp), // Style for hint text
                      ),
                      textInputAction:
                          TextInputAction.done, // Adjust action as needed
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Password',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: tdBlack,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3.h),
                Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12).w,
                      border: Border.all(color: tdGrey)),
                  child: Padding(
                    padding: const EdgeInsets.all(5).w, // Add padding for text
                    child: TextField(
                      cursorColor: tdGrey,
                      decoration: InputDecoration(
                        border:
                            InputBorder.none, // Removes the default underline
                        hintText: 'Your password', // Placeholder text
                        hintStyle: TextStyle(
                            color: tdGrey,
                            fontSize: 12.sp), // Style for hint text
                      ),
                      textInputAction:
                          TextInputAction.done, // Adjust action as needed
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    context.push("/home");
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12).w,
                        color: tdBlueLight),
                    child: Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: tdWhite,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(fontSize: 12.sp, color: tdGrey),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Did not have a RentWay account?',
                      style: TextStyle(fontSize: 12.sp, color: tdGrey),
                    ),
                    TextButton(
                        onPressed: () {
                         context.push("/signUp");
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: tdBlueLight,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
