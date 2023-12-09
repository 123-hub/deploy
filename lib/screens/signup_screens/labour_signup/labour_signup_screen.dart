import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/labour_signup_screen_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_appbar.dart';
import 'package:flutter_project_labour_app/screens/common/auth_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/next_button.dart';
import 'package:flutter_project_labour_app/screens/common/text_field_date_picker.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/labour_signup/labour_aditional_info_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LabourSignUpScreen extends StatelessWidget {
  LabourSignUpScreen({super.key});

  final signupScreenController = Get.find<LabourSignupScreenController>();
  @override
  Widget build(BuildContext context) {
    debugPrint(signupScreenController.emailTextController.text);
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
                  'Let’s create an account\nfor you',
                  style: authHeading,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  'For a better future',
                  style: subtitle.copyWith(color: subtitleGrey),
                ),
                SizedBox(
                  height: 26.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController:
                        signupScreenController.firstNameTextController,
                    hintText: 'First Name',
                    isPasswordField: false,
                    primaryIcon: Icons.person_outline,
                    textInputType: TextInputType.name,
                    errorText: signupScreenController.isFirstNameValid.value
                        ? null
                        : signupScreenController.firstNameErrorMessage,
                  );
                }),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController:
                        signupScreenController.lastNameTextController,
                    hintText: 'Last Name',
                    isPasswordField: false,
                    primaryIcon: Icons.person_2_outlined,
                    textInputType: TextInputType.name,
                    errorText: signupScreenController.isLastNameValid.value
                        ? null
                        : signupScreenController.lastNameErrorMessage,
                  );
                }),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController:
                        signupScreenController.phoneNumberTextController,
                    hintText: 'Phone number',
                    isPasswordField: false,
                    primaryIcon: Icons.phone,
                    textInputType: TextInputType.phone,
                    errorText: signupScreenController.isPhoneNumberValid.value
                        ? null
                        : signupScreenController.phoneNumberErrorMessage,
                  );
                }),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return TextFieldDatePicker(
                    controller: signupScreenController.dateTextController,
                    hintText: 'Enter your DOB',
                    initialDate: DateTime(2005),
                    firstDate: DateTime(1940),
                    lastDate: DateTime(2006),
                    onTap: (DateTime date) {
                      String formatedDate =
                          DateFormat('dd/MM/yyyy').format(date);
                      signupScreenController.dateTextController.text =
                          formatedDate;
                      signupScreenController.dateOfBirth = date;
                    },
                    errorMessage: signupScreenController.isDOBValid.value
                        ? null
                        : signupScreenController.dobErrorMessage,
                  );
                }),
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
                    emailTextController:
                        signupScreenController.passwordTextController,
                    hintText: 'Enter Your Password',
                    isPasswordField: true,
                    primaryIcon: Icons.lock_outline,
                    showPassword: signupScreenController.showPassword.value,
                    textInputType: TextInputType.visiblePassword,
                    errorText: signupScreenController.isPasswordValid.value
                        ? null
                        : signupScreenController.passwordErrorMessage,
                    visibilityButton: () {
                      signupScreenController.chageShowPassword();
                    },
                  );
                }),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController:
                        signupScreenController.confirmPasswordTextController,
                    hintText: 'Confirm Your password',
                    isPasswordField: true,
                    primaryIcon: Icons.lock_outline,
                    showPassword:
                        signupScreenController.showConfirmPassword.value,
                    textInputType: TextInputType.visiblePassword,
                    errorText: signupScreenController
                            .isConfirmPasswordValid.value
                        ? null
                        : signupScreenController.confirmPasswordErrorMessage,
                    visibilityButton: () {
                      signupScreenController.chageConfirmShowPassword();
                    },
                  );
                }),
                SizedBox(
                  height: 100.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: NextButton(
                    text: 'Next',
                    isArrowPresent: true,
                    onPressed: () {
                      if (signupScreenController.isFirstPageValid()) {
                        Get.to(() => AdditionalInfoScreen());
                      }
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
