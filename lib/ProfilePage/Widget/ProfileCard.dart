import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color/color.dart';


class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15).w,
          color: Colors.blueAccent
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25).w,
            child: SizedBox(
              height: 33.h,
              width: 35.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7).w,
                child: CachedNetworkImage(
                  imageUrl: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                  fit: BoxFit.fill,
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress, color: tdBlueLight,),
                  errorWidget:
                      (context, url, error) =>
                  const Icon(Icons.error),
                ),
              ),
            ),
          ),
          SizedBox(width: 20.w,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Walid Jallad',style: TextStyle(fontWeight: FontWeight.bold,color: tdWhite,fontSize: 15.sp),),
              Text('wjallad55@gmail.com',style: TextStyle(fontSize: 12.sp,color: tdWhite,fontWeight: FontWeight.w400),)
            ],
          )
        ],
      ),
    );
  }
}
