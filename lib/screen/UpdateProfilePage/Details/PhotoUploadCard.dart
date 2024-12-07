import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/provider/User_Provider.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provider/provider.dart";


class PhotoUploadCard extends StatelessWidget {
  const PhotoUploadCard({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true);
    var userDetails = user.userDetails;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 70.w,
            height: 60.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10).w,
              child: CachedNetworkImage(
                imageUrl: userDetails!.photo!.url.isEmpty
                    ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
                    : userDetails.photo!.url,
                fit: BoxFit.fill,
                progressIndicatorBuilder:
                    (context, url, downloadProgress) =>
                        CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: tdBlueLight,
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
              ),
            ),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                'Change profile picture',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.w500),
              ))
        ],
      ),
    );
  }
}

