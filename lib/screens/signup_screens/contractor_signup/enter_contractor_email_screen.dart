import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_signup_screen_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/progress_hud.dart';
import 'package:flutter_project_labour_app/screens/login_screens/components/auth_back_appbar.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/contractor_signup/enter_contractor_otp_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EnterContractorEmailScreen extends StatelessWidget {
  EnterContractorEmailScreen({super.key});
  final contractorSignUpScreenController = Get.put(ContractorSignUpScreenController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
          return ProgressHud(
            inAsyncCall: contractorSignUpScreenController.isSendingOTP.value,
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
                        'Don’t worry! It happens to the best of us',
                        style: subtitle.copyWith(color: subtitleGrey),
                      ),
                      SizedBox(
                        height: 39.h,
                      ),
                      AuthTextField(
                        emailTextController:
                            contractorSignUpScreenController.emailTextController,
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
                          var sent = await contractorSignUpScreenController.sendOtp();
                          if (sent) {
                            Get.off(() => EnterContractorOTPScreen());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
