import 'package:carrent/core/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


class ProfilePageCard extends StatelessWidget {
  const ProfilePageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (){
            GoRouter.of(context).goNamed('ProfileUpdate');
          },
          child: Row(
            children: [
              Container(
                width: 35.w,
                height: 30.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10).w,
                    border: Border.all(color: tdBlack)
                ),
                child: Center(
                  child: Icon(Icons.person_2_outlined,size: 20.w,),
                ),
              ),
              SizedBox(width: 15.w,),
              Text('Account Profile',style: TextStyle(fontSize: 12.sp,color: tdBlueLight,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
        SizedBox(height: 10.h,),
        Divider(color: tdGrey,thickness: 0.5.w,),
        SizedBox(height: 10.h,),
        GestureDetector(
          onTap: (){
            //
          },
          child: Row(
            children: [
              Container(
                width: 35.w,
                height: 30.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10).w,
                    border: Border.all(color: tdBlack)
                ),
                child: Center(
                  child: Icon(Icons.book_online_outlined,size: 20.w,),
                ),
              ),
              SizedBox(width: 15.w,),
              Text('My Booking',style: TextStyle(fontSize: 12.sp,color: tdBlueLight,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
        SizedBox(height: 10.h,),
        Divider(color: tdGrey,thickness: 0.5.w,),
        SizedBox(height: 10.h,),
        GestureDetector(
          onTap: (){
            //
          },
          child: Row(
            children: [
              Container(
                width: 35.w,
                height: 30.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10).w,
                    border: Border.all(color: tdBlack)
                ),
                child: Center(
                  child: Icon(Icons.notification_important_rounded,size: 20.w,),
                ),
              ),
              SizedBox(width: 15.w,),
              Text('Notification',style: TextStyle(fontSize: 12.sp,color: tdBlueLight,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
        SizedBox(height: 10.h,),
        Divider(color: tdGrey,thickness: 0.5.w,),
        SizedBox(height: 10.h,),
        GestureDetector(
          onTap: (){
            //
          },
          child: Row(
            children: [
              Container(
                width: 35.w,
                height: 30.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10).w,
                    border: Border.all(color: tdBlack)
                ),
                child: Center(
                  child: Icon(Icons.password,size: 20.w,),
                ),
              ),
              SizedBox(width: 15.w,),
              Text('Change Password',style: TextStyle(fontSize: 12.sp,color: tdBlueLight,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
        SizedBox(height: 10.h,),
        Divider(color: tdGrey,thickness: 0.5.w,)
      ],
    );
  }
}
