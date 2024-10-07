import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrent/Color/color.dart';
import 'package:carrent/provider/Promo_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PromoProvider>(context, listen: false).fetchPromos();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 200) {
      Provider.of<PromoProvider>(context, listen: false).fetchPromos();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      appBar: AppBar(
        title: Text(
          'Promotion',
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
                GoRouter.of(context).go('/home');
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20.w,
                color: tdGrey,
              )),
        ),
      ),
      body: Consumer<PromoProvider>(
        builder: (context, promoProvider, child) {
          if (promoProvider.isLoading && promoProvider.promos.isEmpty) {
            return const Center(
                child: CircularProgressIndicator(color: tdBlueLight));
          }
          if (promoProvider.promos.isEmpty) {
            return Center(
              child: Text(
                'No promo added yet',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: promoProvider.promos.length +
                (promoProvider.hasMoreData ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == promoProvider.promos.length) {
                return const Center(
                    child: CircularProgressIndicator(color: tdBlueLight));
              }
              final promoData = promoProvider.promos[index];
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5).w,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pushNamed('PromoDetails',
                            pathParameters: {'id': promoData.id.toString()});
                      },
                      child: SizedBox(
                        height: 170.h,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15).w,
                          child: CachedNetworkImage(
                            imageUrl: (promoData.promoImage.url.isNotEmpty)
                                ? promoData.promoImage.url
                                : 'https://www.its.ac.id/tmesin/wp-content/uploads/sites/22/2022/07/no-image.png',
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
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      promoData.promoTitle,
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: tdBlueLight,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15.sp,
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
