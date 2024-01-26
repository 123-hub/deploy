import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/forgot_password_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_appbar.dart';
import 'package:flutter_project_labour_app/screens/forgot_password/forgot_password_enter_email.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/long_grey_button.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPasswordRole extends StatelessWidget {
  ForgetPasswordRole({super.key});
  final forgotPasswordController = Get.put(ForgotPasswordController(), permanent: true);
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
                  'Choose your role',
                  style: authHeading,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  'What was your role in your account',
                  style: subtitle.copyWith(color: subtitleGrey),
                ),
                SizedBox(
                  height: 200.h,
                ),
                LongOutlineButton(
                  text: 'Labour',
                  onPressed: () {
                    forgotPasswordController.role = 'labour';
                    Get.off(() => ForgotPasswordEnterEmail());
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                LongOutlineButton(
                  text: 'Contractor',
                  onPressed: () {
                    forgotPasswordController.role = 'contractor';
                    Get.off(() => ForgotPasswordEnterEmail());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
