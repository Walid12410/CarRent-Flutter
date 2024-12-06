import "package:carrent/core/Color/color.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(
              fontSize: 15.sp, color: tdBlueLight, fontWeight: FontWeight.bold),
        ),
        backgroundColor: tdWhite,
        shadowColor: tdWhite,
        surfaceTintColor: tdWhite,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20).w,
          child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20.w,
                color: tdGrey,
              )),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
