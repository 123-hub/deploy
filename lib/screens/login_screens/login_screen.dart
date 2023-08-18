import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/login_screen_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_appbar.dart';
import 'package:flutter_project_labour_app/screens/common/auth_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/role_drop_down_menu.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/role_signup_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/dashboard_screen.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/labour_forgot_password/enter_email_screen.dart';
import 'package:flutter_project_labour_app/screens/login_screens/components/social_login_button.dart';
import 'package:flutter_project_labour_app/screens/login_screens/components/social_login_divider.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/labour_signup/labour_signup_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final loginScreenController = Get.put(LoginScreenController());

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
                  height: 100.h,
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
                Obx(
                  () {
                    return RoleDropDownMenu(
                      value: loginScreenController.role.value,
                      onChanged: loginScreenController.onRoleChange,
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController:
                        loginScreenController.emailTextController,
                    hintText: 'Enter your email',
                    isPasswordField: false,
                    primaryIcon: Icons.alternate_email,
                    textInputType: TextInputType.emailAddress,
                    errorText: loginScreenController.isEmailValid.value
                        ? null
                        : loginScreenController.emailErrorMessage,
                  );
                }),
                SizedBox(
                  height: 33.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController:
                        loginScreenController.passwordTextController,
                    hintText: 'Enter your password',
                    isPasswordField: true,
                    primaryIcon: Icons.lock_outline,
                    showPassword: loginScreenController.showPassword.value,
                    textInputType: TextInputType.visiblePassword,
                    errorText: loginScreenController.isPasswordValid.value
                        ? null
                        : loginScreenController.passwordErrorMessage,
                    visibilityButton: () {
                      loginScreenController.chageShowPassword();
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
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    var isValid = loginScreenController.areTextFieldValid();
                    debugPrint('Are text field Valid: $isValid');
                    if (isValid) {
                      await loginScreenController.loginUser();
                      if (loginScreenController.loginResponse.value != null) {
                        debugPrint('Login Succesfull');
                        Get.off(() => DashboardScreen());
                      } else {
                        debugPrint('facing problem');
                      }
                    }
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
                        Get.to(() => const RoleSignUpScreen());
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
