import 'package:carrent/Api/UserService.dart';
import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/Widget/Toast/ToastValidation.dart';
import 'package:carrent/core/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _retypePassword = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool isLoading = false;


  void submitHandler(password) async {
    UserService service = UserService();
    setState(() {
      isLoading = true;
    });
    if(password == ""){
      showValidationToast('can not take empty field');
      return;
    }

    try {
      bool isUpdated = await service.updatePassword(password);
      if(isUpdated) {
        setState(() {
         context.pop();
        });
      } 
    } catch (e) {
      showToast('Something went wrong');
    } finally{
      setState(() {
        isLoading = false;
      });
    }
  }

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
                SizedBox(height: 10.h),
                IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20.w,
                      color: tdGrey,
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Change Password',
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'New password',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3.h),
                Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12).w,
                      border: Border.all(color: tdGrey)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5).w,
                    child: TextField(
                      cursorColor: tdGrey,
                      obscureText: !_isPasswordVisible, // Control visibility
                      controller: _newPassword,
                      style: TextStyle(
                        color: tdBlueLight,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'New password',
                        hintStyle: TextStyle(color: tdGrey, fontSize: 12.sp),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: tdGrey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'Retype new password',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3.h),
                Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12).w,
                      border: Border.all(color: tdGrey)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5).w,
                    child: TextField(
                      cursorColor: tdGrey,
                      obscureText: !_isConfirmPasswordVisible, // Control visibility
                      controller: _retypePassword,
                      style: TextStyle(
                        color: tdBlueLight,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Retype new password',
                        hintStyle: TextStyle(color: tdGrey, fontSize: 12.sp),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: tdGrey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 8, right: 8).w,
        child: BottomAppBar(
          surfaceTintColor: tdWhite,
          color: tdWhite,
          height: 55.h,
          child: GestureDetector(
            onTap:isLoading ? null : () {
              if(_newPassword.text != _retypePassword.text){
                showToast('Password not match');
                return;
              }

              submitHandler(_newPassword.text);
            },
            child: Container(
              height: 40.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: tdBlueLight,
                borderRadius: BorderRadius.circular(10).w,
              ),
              child: Center(
                child: Text(
                 isLoading? 'Updating...' : 'Change password',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: tdWhite,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
