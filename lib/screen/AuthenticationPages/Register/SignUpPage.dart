import 'package:carrent/Api/AuthenticationService.dart';
import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/core/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  void register(fName, lName, number, email, pass) async {
    Authentication service = Authentication();
    setState(() {
      isLoading = true;
    });
    bool isSignup = await service.signup(fName, lName, number, email, pass);
    try {
      if (isSignup) {
        setState(() {
          GoRouter.of(context).go("/logIn");
        });
      }
    } catch (e) {
      showToast('Something went wrong, check you connection');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
                SizedBox(height: 15.h),
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
                  'Welcome to RentWay! 🎉',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: tdBlack),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Create your account to start renting with ease',
                  style: TextStyle(fontSize: 12.sp, color: tdGrey),
                ),
                SizedBox(height: 15.h),
                Text(
                  'First Name',
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
                      controller: firstName,
                      cursorColor: tdGrey,
                      decoration: InputDecoration(
                        border:
                            InputBorder.none, // Removes the default underline
                        hintText: 'Enter your first name', // Placeholder text
                        hintStyle: TextStyle(
                            color: tdGrey,
                            fontSize: 12.sp), // Style for hint text
                      ),
                      textInputAction:
                          TextInputAction.done, // Adjust action as needed
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'Last Name',
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
                      controller: lastName,
                      decoration: InputDecoration(
                        border:
                            InputBorder.none, // Removes the default underline
                        hintText: 'Enter you last name', // Placeholder text
                        hintStyle: TextStyle(
                            color: tdGrey,
                            fontSize: 12.sp), // Style for hint text
                      ),
                      textInputAction:
                          TextInputAction.done, // Adjust action as needed
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'Phone number',
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
                      controller: phoneNumber,
                      decoration: InputDecoration(
                        border:
                            InputBorder.none, // Removes the default underline
                        hintText: 'Enter your phone number', // Placeholder text
                        hintStyle: TextStyle(
                            color: tdGrey,
                            fontSize: 12.sp), // Style for hint text
                      ),
                      textInputAction:
                          TextInputAction.done, // Adjust action as needed
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
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
                      controller: emailAddress,
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
                SizedBox(height: 15.h),
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
                      controller: password,
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
                  height: 15.h,
                ),
                GestureDetector(
                  onTap: isLoading
                      ? null
                      : () {
                          //@TODO validation for empty field
                          register(
                              firstName.text,
                              lastName.text,
                              phoneNumber.text,
                              emailAddress.text,
                              password.text);
                        },
                  child: Container(
                    width: double.infinity,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12).w,
                        color: tdBlueLight),
                    child: Center(
                        child: Text(
                      isLoading ? "Creating..." : "Create account",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: tdWhite,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Already have account?',
                      style: TextStyle(fontSize: 12.sp, color: tdGrey),
                    ),
                    TextButton(
                        onPressed: () {
                          context.push("/logIn");
                        },
                        child: Text(
                          'Login',
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
