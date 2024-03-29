import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/screens/login_screens/login_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpComplete extends StatelessWidget {
  const SignUpComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: allSetPageBackground,
                child: Center(
                  child: Image.asset('assets/images/all_set.png'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 37.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    Text(
                      "All Set",
                      style: authHeading,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'All steps for Sign up has been completed and now you are a valid user of this platform, and can access all features here without any restrictions',
                      style:
                          authInfoHeading.copyWith(color: allSetPageTextColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => LoginScreen());
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primaryRed),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        child: Text(
                          'Lets Go',
                          style: branding16sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
