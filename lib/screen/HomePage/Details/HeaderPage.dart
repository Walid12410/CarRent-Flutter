import 'package:carrent/core/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HeaderPage extends StatelessWidget {
  const HeaderPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
              Text(
                'Lebanon, Beirut',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: tdBlueLight),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search_rounded, size: 22.w, color: tdGrey)),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notification_important_outlined,
                      size: 22.w, color: tdGrey)),
            ],
          )
        ],
      ),
    );
  }
}
