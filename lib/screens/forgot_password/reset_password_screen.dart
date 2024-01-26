import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/forgot_password_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/progress_hud.dart';
import 'package:flutter_project_labour_app/screens/login_screens/components/auth_back_appbar.dart';
import 'package:flutter_project_labour_app/screens/login_screens/login_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final forgotPasswordController = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ProgressHud(
          inAsyncCall: forgotPasswordController.isLoading.value,
          child: SafeArea(
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
                      'Enter new password and confirm it for proceeding',
                      style: subtitle.copyWith(color: subtitleGrey),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    Obx(() {
                      return AuthTextField(
                        emailTextController:
                            forgotPasswordController.passwordTextController,
                        hintText: 'Set New Password',
                        isPasswordField: true,
                        primaryIcon: Icons.lock_outline,
                        showPassword:
                            forgotPasswordController.showPassword.value,
                        textInputType: TextInputType.visiblePassword,
                        visibilityButton: () {
                          forgotPasswordController.changeShowPassword();
                        },
                        errorText:
                            forgotPasswordController.isPasswordValid.value
                                ? null
                                : forgotPasswordController.passwordErrorMessage,
                      );
                    }),
                    SizedBox(
                      height: 25.h,
                    ),
                    Obx(() {
                      return AuthTextField(
                        emailTextController: forgotPasswordController
                            .confirmPasswordTextController,
                        hintText: 'Confirm New password',
                        isPasswordField: true,
                        primaryIcon: Icons.lock_outline,
                        textInputType: TextInputType.visiblePassword,
                        showPassword:
                            forgotPasswordController.showPassword.value,
                        visibilityButton: () {
                          forgotPasswordController.changeShowConfirmPassword();
                        },
                        errorText: forgotPasswordController
                                .isConfirmPasswordValid.value
                            ? null
                            : forgotPasswordController
                                .confirmPasswordErrorMessage,
                      );
                    }),
                    SizedBox(
                      height: 33.h,
                    ),
                    LongButton(
                      text: 'Reset Password',
                      onPressed: () async {
                        if (forgotPasswordController.checkPasswordFields() &&
                            forgotPasswordController.checkPasswordSame()) {
                          var result =
                              await forgotPasswordController.resetPassword();
                          if (result) {
                            Get.delete<ForgotPasswordController>(force: true);
                            Get.offAll(() => LoginScreen());
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
