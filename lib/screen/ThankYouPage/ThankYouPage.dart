import "package:carrent/core/Color/color.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";


class ThankYouPage extends StatefulWidget {
  const ThankYouPage({super.key});

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20).w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80.h,),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/thankYou.png',width: double.infinity,height: 200.h,fit: BoxFit.cover,),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text('Your booking success!',style: TextStyle(fontSize: 18.sp,color: tdBlueLight,fontWeight: FontWeight.bold),)
                ),
                SizedBox(height: 10.h,),
                Align(
                  alignment: Alignment.center,
                  child: Text('Congratulation your booking has been made.',style: TextStyle(fontSize: 12.sp,color: tdGrey,fontWeight: FontWeight.bold),)
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text('Thanks for trusting us!',style: TextStyle(fontSize: 12.sp,color: tdGrey,fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: tdWhite,
        color: tdWhite,
        child: GestureDetector(
          onTap: (){
            context.go('/home');
          },
          child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: tdBlueLight,
                borderRadius: BorderRadius.circular(12).w
              ),
              child:Center(
                child: Text("Back to homepage",style: TextStyle(
                  fontSize: 15.sp,color: tdWhite,fontWeight: FontWeight.bold
                ),),
              ) ,),
        )
      ),
    
    );
  }
}