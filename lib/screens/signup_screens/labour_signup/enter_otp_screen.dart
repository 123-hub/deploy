import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/labour_signup_screen_controller.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/progress_hud.dart';
import 'package:flutter_project_labour_app/screens/login_screens/components/auth_back_appbar.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/labour_signup/labour_signup_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class EnterOTPScreen extends StatelessWidget {
  EnterOTPScreen({super.key});
  final signupScreenController = Get.find<LabourSignupScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ProgressHud(
          inAsyncCall: signupScreenController.isVerifyingOTP.value,
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
                      height: 200.h,
                    ),
                    Text(
                      'Enter OTP',
                      style: authHeading,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      'With this your email will be varified',
                      style: subtitle.copyWith(color: subtitleGrey),
                    ),
                    SizedBox(
                      height: 39.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Pinput(
                        length: 5,
                        onCompleted: (String? pin) {
                          if (pin != null) {
                            signupScreenController.otp = pin;
                          }
                        },
                        separator: SizedBox(width: 11.w),
                        defaultPinTheme: PinTheme(
                          height: 47.h,
                          width: 47.w,
                          textStyle: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp,
                            color: otpColor,
                          ),
                          decoration: BoxDecoration(
                            color: otpBoxColor,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    LongButton(
                      text: 'Submit',
                      onPressed: () async {
                        var sent = await signupScreenController.verifyOtp();
                        if (sent) {
                          Get.lazyPut(() => LabourSignupScreenController());
                          Get.off(() => LabourSignUpScreen());
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
