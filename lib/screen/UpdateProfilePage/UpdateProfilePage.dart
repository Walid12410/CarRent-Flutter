import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/model/User/UserModel.dart";
import "package:carrent/provider/User_Provider.dart";
import "package:carrent/screen/UpdateProfilePage/Details/PhotoUploadCard.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true);
    var userDetails = user.userDetails;

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
              SizedBox(height: 10.h),
              IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20.w,
                    color: tdGrey,
                  )),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Account Profile',
                style: TextStyle(
                    fontSize: 20.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              PhotoUploadCard(userDetails: userDetails),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'First Name',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: tdBlueLight,
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
                      border: InputBorder.none, // Removes the default underline
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
                    color: tdBlueLight,
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
                      border: InputBorder.none, // Removes the default underline
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
                    color: tdBlueLight,
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
                      border: InputBorder.none, // Removes the default underline
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
            ],
          ),
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15,left: 8,right: 8).w,
        child: BottomAppBar(
          surfaceTintColor: tdWhite,
          color: tdWhite,
          height: 55.h,
          child: GestureDetector(
            onTap: (){
              // method call
            },
            child: Container(
              height: 40.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: tdBlueLight,
                borderRadius: BorderRadius.circular(10).w,
              ),
              child: Center(
                child: Text(
                  'Update profile',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: tdWhite,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
