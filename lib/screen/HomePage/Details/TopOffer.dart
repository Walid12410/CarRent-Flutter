import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrent/core/Color/color.dart';
import 'package:carrent/model/Offer/OfferModel.dart';
import 'package:carrent/provider/Offer_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class TopOfferCard extends StatelessWidget {
  const TopOfferCard({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final offer = Provider.of<OfferProvider>(context, listen: true);
    var topOffers = offer.topOffer;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 20).w,
        child: Row(
          children: [
            for(Offer offerList in topOffers)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10).w,
                    child: SizedBox(
                      height: 110.h,
                      width: 200.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15).w,
                        child: CachedNetworkImage(
                          imageUrl: (offerList.car?.carImage.isNotEmpty ?? false)
                              ? offerList.car!.carImage[0].carImage.url
                              : 'default_image_url',
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
                  SizedBox(
                    width: 170.w,
                    height: 30.h,
                    child: Text(offerList.offerTitle,
                      style: TextStyle(fontWeight: FontWeight.bold,color: tdBlueLight,fontSize: 12.sp),textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 5.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('\$${offerList.car!.rentPrice} / day',style: TextStyle(fontSize: 10.sp,color: tdBlueLight,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                        decorationThickness:3,
                        decorationColor: tdGrey,
                      ),),
                      Text('   \$${offerList.discountPrice}/ day',style: TextStyle(fontSize: 12.sp,color: Colors.red,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
