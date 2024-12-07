import "package:carrent/core/Color/color.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";


class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20).w,
            child: Column(
              children: [
                SizedBox(height: 10.h,),
                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,size: 20.w,color: tdGrey,)),
                SizedBox(height: 10.h,),
                Text('Checkout',style: TextStyle(fontSize: 18.sp,color: tdBlueLight,fontWeight: FontWeight.bold),),
                SizedBox(height: 15.h),
                Text('CAR DETAIL',style: TextStyle(fontSize: 12.sp,color: tdBlueLight,fontWeight: FontWeight.w500),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}