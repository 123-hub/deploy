import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/app_state_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/login_screens/components/auth_back_appbar.dart';
import 'package:flutter_project_labour_app/screens/login_screens/login_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final appStateController = Get.put(AppStateController());

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
                  height: 40.h,
                ),
                const AuthBackAppBar(),
                SizedBox(
                  height: 140.h,
                ),
                Text(
                  'Reset Password',
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
                  height: 28.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController: passwordTextController,
                    hintText: 'Set New Password',
                    isPasswordField: true,
                    primaryIcon: Icons.lock_outline,
                    showPassword: appStateController.showPassword.value,
                    visibilityButton: () {
                      appStateController.chageShowPassword();
                    },
                  );
                }),
                SizedBox(
                  height: 25.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController: confirmPasswordTextController,
                    hintText: 'Confirm New password',
                    isPasswordField: true,
                    primaryIcon: Icons.lock_outline,
                    showPassword: appStateController.showPassword.value,
                    visibilityButton: () {
                      appStateController.chageConfirmShowPassword();
                    },
                  );
                }),
                SizedBox(
                  height: 33.h,
                ),
                LongButton(
                  text: 'Reset Password',
                  onPressed: () {
                    Get.offAll(() => LoginScreen());
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
