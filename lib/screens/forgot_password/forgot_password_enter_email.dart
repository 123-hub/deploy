import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/forgot_password_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/progress_hud.dart';
import 'package:flutter_project_labour_app/screens/forgot_password/forgot_password_otp.dart';
import 'package:flutter_project_labour_app/screens/login_screens/components/auth_back_appbar.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordEnterEmail extends StatelessWidget {
  ForgotPasswordEnterEmail({super.key});

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
                      height: 206.h,
                    ),
                    Text(
                      'Enter Email',
                      style: authHeading,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      'Enter the email of the account of which you want to change the password',
                      style: subtitle.copyWith(color: subtitleGrey),
                    ),
                    SizedBox(
                      height: 39.h,
                    ),
                    AuthTextField(
                      emailTextController:
                          forgotPasswordController.emailController,
                      hintText: 'Enter your email',
                      isPasswordField: false,
                      primaryIcon: Icons.alternate_email,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    LongButton(
                      text: 'Submit',
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        var sent = await forgotPasswordController.sendOtp();
                        if (sent) {
                          Get.off(() => ForgotPasswordOTP());
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
