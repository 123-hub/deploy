import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/app_state_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_appbar.dart';
import 'package:flutter_project_labour_app/screens/common/auth_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/dashboard_screen/dashboard_screen.dart';
import 'package:flutter_project_labour_app/screens/login_screen/forgot_password/enter_email_screen.dart';
import 'package:flutter_project_labour_app/screens/login_screen/components/social_login_button.dart';
import 'package:flutter_project_labour_app/screens/login_screen/components/social_login_divider.dart';
import 'package:flutter_project_labour_app/screens/signup_screen/signup_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
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
                  height: 138.h,
                ),
                Text(
                  'Login to your account',
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
                  height: 39.h,
                ),
                AuthTextField(
                  emailTextController: emailTextController,
                  hintText: 'Enter your email',
                  isPasswordField: false,
                  primaryIcon: Icons.alternate_email,
                ),
                SizedBox(
                  height: 33.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController: passwordTextController,
                    hintText: 'Enter your password',
                    isPasswordField: true,
                    primaryIcon: Icons.lock_outline,
                    showPassword: appStateController.showPassword.value,
                    visibilityButton: () {
                      appStateController.chageShowPassword();
                    },
                  );
                }),
                SizedBox(
                  height: 11.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => EnterEmailScreen());
                    },
                    child: Text(
                      'Forgot Password?',
                      style: subtitle.copyWith(
                        color: primeryRed,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                LongButton(
                  text: 'Sign In',
                  onPressed: () {
                    Get.off(() => DashboardScreen());
                  },
                ),
                SizedBox(
                  height: 26.h,
                ),
                const SocialLoginDivider(),
                SizedBox(
                  height: 23.h,
                ),
                const SocialLoginButton(
                  name: 'Google',
                  color: Colors.black,
                  image: 'assets/images/google.png',
                ),
                SizedBox(
                  height: 12.h,
                ),
                const SocialLoginButton(
                  name: 'Facebook',
                  color: Color(0xFF3C5A9A),
                  image: 'assets/images/facebook.png',
                ),
                SizedBox(
                  height: 100.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account? ',
                      style: subtitle.copyWith(
                        color: bottomGrey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => SignUpScreen());
                      },
                      child: Text(
                        'Create one',
                        style: subtitle.copyWith(
                          color: primeryRed,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
