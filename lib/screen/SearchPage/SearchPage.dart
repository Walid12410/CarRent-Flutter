import "package:carrent/core/Color/color.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20).w,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    IconButton(
                        onPressed: () {
                          GoRouter.of(context).go('/home');
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 20.w,
                          color: tdGrey,
                        )),
                    SizedBox(
                      height: 20.w,
                    ),
                    Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12).w,
                          border: Border.all(color: tdGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(5).w,
                        child: TextField(
                          cursorColor: tdGrey,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search for special car",
                              hintStyle:
                                  TextStyle(color: tdGrey, fontSize: 12.sp),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: tdGrey,
                                size: 20.w,
                              )),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: tdWhite,
          surfaceTintColor: tdWhite,
          shadowColor: tdWhite,
          child: Padding(
            padding: const EdgeInsets.only(left: 110,right: 110).w,
            child: Container(
              decoration: BoxDecoration(
                color: tdBlueLight,
                borderRadius: BorderRadius.circular(17).w
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // google map page
                    },
                    child: Row(
                      children: [
                        Icon(Icons.location_on_sharp,color: tdWhite,size: 15.w,),
                        Text('Maps',style: TextStyle(fontSize: 12.sp,color: tdWhite),)
                      ]
                    ),
                  ),
                  SizedBox(width: 5.w,),
                    GestureDetector(
                    onTap: (){
                      // filter
                    },
                    child: Row(
                      children: [
                        Icon(Icons.filter_alt,color: tdWhite,size: 15.w,),
                        Text('Filter',style: TextStyle(fontSize: 12.sp,color: tdWhite),)
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
