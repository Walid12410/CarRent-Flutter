import 'package:carrent/core/Color/color.dart';
import "package:carrent/model/Notification/NotificationModel.dart";
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    required this.formattedDate,
  });

  final NotificationModel notification;
  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
              left: 20, right: 20, top: 5, bottom: 5)
          .w,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12).w,
          color: tdWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5).w,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 180.w,
                      child: Text(
                        notification.title,
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: tdBlueLight,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: tdGrey,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  notification.body,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.w400),
                )
              ]),
        ),
      ),
    );
  }
}
