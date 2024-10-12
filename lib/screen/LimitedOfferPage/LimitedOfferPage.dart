import "package:carrent/core/Color/color.dart";
import "package:carrent/provider/Offer_Provider.dart";
import "package:carrent/screen/LimitedOfferPage/Details/OfferLimitedCard.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

class LimitedOfferPage extends StatefulWidget {
  const LimitedOfferPage({super.key});

  @override
  State<LimitedOfferPage> createState() => _LimitedOfferPageState();
}

class _LimitedOfferPageState extends State<LimitedOfferPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OfferProvider>(context, listen: false).fetchOffers();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 200) {
      Provider.of<OfferProvider>(context, listen: false).fetchOffers();
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
            'Limited Offer',
            style: TextStyle(
                fontSize: 15.sp,
                color: tdBlueLight,
                fontWeight: FontWeight.bold),
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
        body: Consumer<OfferProvider>(
          builder: (context, offerProvider, child) {
            if (offerProvider.isLoading && offerProvider.offers.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: tdBlueLight,
                ),
              );
            }
            
            if (offerProvider.offers.isEmpty) {
              return Center(
                child: Text(
                  'No offer added yet',
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
                itemCount: offerProvider.offers.length +
                    (offerProvider.hasMoreData ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == offerProvider.offers.length) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: tdBlueLight,
                      ),
                    );
                  }
                  final offer = offerProvider.offers[index];
                  DateTime parsedDate = DateTime.parse(offer.endDate); // Parse the ISO date
                  return OfferLimitCard(offer: offer, parsedDate: parsedDate);
                });
          },
        ));
  }
}
