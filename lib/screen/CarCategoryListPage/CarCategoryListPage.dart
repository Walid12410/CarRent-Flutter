import "package:carrent/core/Color/color.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class CarCategoryListPage extends StatefulWidget {
  const CarCategoryListPage({super.key,required this.categoryId });

  final String categoryId;
  @override
  State<CarCategoryListPage> createState() => _CarCategoryListPageState();
}

class _CarCategoryListPageState extends State<CarCategoryListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text('asdasdasd',style: TextStyle(fontSize: 12.sp),)
          ],
        ),
      )),
    );
  }
}
