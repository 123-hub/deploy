import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/app_state_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_appbar.dart';
import 'package:flutter_project_labour_app/screens/common/auth_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/next_button.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/aditional_info_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
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
                const AuthAppBar(),
                SizedBox(
                  height: 71.h,
                ),
                Text(
                  'Let’s create an account\nfor you',
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
                  height: 26.h,
                ),
                AuthTextField(
                  emailTextController: nameTextController,
                  hintText: 'Name',
                  isPasswordField: false,
                  primaryIcon: Icons.person_outline,
                ),
                SizedBox(
                  height: 20.h,
                ),
                AuthTextField(
                  emailTextController: emailTextController,
                  hintText: 'E-Mail Address',
                  isPasswordField: false,
                  primaryIcon: Icons.alternate_email,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Make sure you select a strong password to protect your account',
                  style: subtitle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: subtitleGrey,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController: passwordTextController,
                    hintText: 'Enter Your Password',
                    isPasswordField: true,
                    primaryIcon: Icons.lock_outline,
                    showPassword: appStateController.showPassword.value,
                    visibilityButton: () {
                      appStateController.chageShowPassword();
                    },
                  );
                }),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController: confirmPasswordTextController,
                    hintText: 'Confirm Your password',
                    isPasswordField: true,
                    primaryIcon: Icons.lock_outline,
                    showPassword: appStateController.showPassword.value,
                    visibilityButton: () {
                      appStateController.chageConfirmShowPassword();
                    },
                  );
                }),
                SizedBox(
                  height: 200.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: NextButton(
                    text: 'Next',
                    isArrowPresent: true,
                    onPressed: () {
                      Get.off(() => AdditionalInfoScreen());
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
