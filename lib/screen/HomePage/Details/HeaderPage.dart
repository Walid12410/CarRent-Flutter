import 'package:carrent/core/Color/color.dart';
import 'package:carrent/core/CurrentLocation.dart';
import 'package:carrent/provider/User_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HeaderPage extends StatelessWidget {
  const HeaderPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true);
    var userDetails = user.userDetails;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 170.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Your location',
                      style: TextStyle(fontSize: 13.sp, color: tdGrey),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 25.w,
                      color: tdGrey,
                    )
                  ],
                ),
                if (userDetails!.locationName == null ||
                    userDetails.locationName == "") ...[
                  GestureDetector(
                    onTap: () {
                      getCurrentLocation();
                    },
                    child: Text(
                      'Allow access',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: tdBlueLight),
                    ),
                  )
                ] else ...[
                  Text(
                    '${userDetails.locationName}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: tdBlueLight),overflow: TextOverflow.ellipsis,
                  )
                ]
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    GoRouter.of(context).goNamed("Search");
                  },
                  icon: Icon(Icons.search_rounded, size: 22.w, color: tdGrey)),
              IconButton(
                  onPressed: () {
                    GoRouter.of(context).goNamed('Notification');
                  },
                  icon: Icon(Icons.notification_important_outlined,
                      size: 22.w, color: tdGrey)),
            ],
          )
        ],
      ),
    );
  }
}
