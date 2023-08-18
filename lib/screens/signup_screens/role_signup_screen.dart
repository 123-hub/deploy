import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/screens/common/auth_appbar.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/long_grey_button.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/labour_forgot_password/enter_email_screen.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/labour_signup/labour_signup_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RoleSignUpScreen extends StatelessWidget {
  const RoleSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 37.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                const AuthAppBar(),
                SizedBox(
                  height: 71.h,
                ),
                Text(
                  'What you want to sign up as?',
                  style: authHeading,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing',
                  style: subtitle.copyWith(color: subtitleGrey),
                ),
                SizedBox(
                  height: 200.h,
                ),
                LongOutlineButton(
                  text: 'Labour',
                  onPressed: () {
                    Get.off(() => EnterEmailScreen());
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                LongOutlineButton(
                  text: 'Contractor',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
