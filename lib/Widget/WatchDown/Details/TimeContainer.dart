import 'package:carrent/core/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeContainer extends StatelessWidget {
  final String label;
  final int value;

  const TimeContainer({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
         Padding(
           padding: const EdgeInsets.all(4).w,
           child: Container(
              width: 35.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: tdWhite,
                borderRadius: BorderRadius.circular(5).w,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset:const Offset(0, 0),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                    '$value',
                    style:  TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold,color: tdGrey),
                  ),
              ),
            ),
         ),
        Text(
          label,
          style: TextStyle(fontSize: 5.sp,color: tdGrey,fontWeight: FontWeight.w500 ),
        ),
      ],
    );
  }
}
