import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_signup_screen_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_appbar.dart';
import 'package:flutter_project_labour_app/screens/common/auth_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/next_button.dart';
import 'package:flutter_project_labour_app/screens/common/text_field_date_picker.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/contractor_signup/contractor_aditional_info_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ContractorSignUpScreen extends StatelessWidget {
  ContractorSignUpScreen({super.key});

  final contractorSignUpScreenController = Get.find<ContractorSignUpScreenController>();
  @override
  Widget build(BuildContext context) {
    debugPrint(contractorSignUpScreenController.emailTextController.text);
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
                  'For hiring talented and hardworking labours',
                  style: subtitle.copyWith(color: subtitleGrey),
                ),
                SizedBox(
                  height: 26.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController:
                        contractorSignUpScreenController.firstNameTextController,
                    hintText: 'First Name',
                    isPasswordField: false,
                    primaryIcon: Icons.person_outline,
                    textInputType: TextInputType.name,
                    errorText: contractorSignUpScreenController.isFirstNameValid.value
                        ? null
                        : contractorSignUpScreenController.firstNameErrorMessage,
                  );
                }),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController:
                        contractorSignUpScreenController.lastNameTextController,
                    hintText: 'Last Name',
                    isPasswordField: false,
                    primaryIcon: Icons.person_2_outlined,
                    textInputType: TextInputType.name,
                    errorText: contractorSignUpScreenController.isLastNameValid.value
                        ? null
                        : contractorSignUpScreenController.lastNameErrorMessage,
                  );
                }),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController:
                        contractorSignUpScreenController.phoneNumberTextController,
                    hintText: 'Phone number',
                    isPasswordField: false,
                    primaryIcon: Icons.phone,
                    textInputType: TextInputType.phone,
                    errorText: contractorSignUpScreenController.isPhoneNumberValid.value
                        ? null
                        : contractorSignUpScreenController.phoneNumberErrorMessage,
                  );
                }),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return TextFieldDatePicker(
                    controller: contractorSignUpScreenController.dateTextController,
                    hintText: 'Enter your DOB',
                    initialDate: DateTime(2005),
                    firstDate: DateTime(1940),
                    lastDate: DateTime(2006),
                    onTap: (DateTime date) {
                      String formatedDate =
                          DateFormat('dd/MM/yyyy').format(date);
                      contractorSignUpScreenController.dateTextController.text =
                          formatedDate;
                      contractorSignUpScreenController.dateOfBirth = date;
                    },
                    errorMessage: contractorSignUpScreenController.isDOBValid.value
                        ? null
                        : contractorSignUpScreenController.dobErrorMessage,
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
                        contractorSignUpScreenController.passwordTextController,
                    hintText: 'Enter Your Password',
                    isPasswordField: true,
                    primaryIcon: Icons.lock_outline,
                    showPassword: contractorSignUpScreenController.showPassword.value,
                    textInputType: TextInputType.visiblePassword,
                    errorText: contractorSignUpScreenController.isPasswordValid.value
                        ? null
                        : contractorSignUpScreenController.passwordErrorMessage,
                    visibilityButton: () {
                      contractorSignUpScreenController.chageShowPassword();
                    },
                  );
                }),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return AuthTextField(
                    emailTextController:
                        contractorSignUpScreenController.confirmPasswordTextController,
                    hintText: 'Confirm Your password',
                    isPasswordField: true,
                    primaryIcon: Icons.lock_outline,
                    showPassword:
                        contractorSignUpScreenController.showConfirmPassword.value,
                    textInputType: TextInputType.visiblePassword,
                    errorText: contractorSignUpScreenController
                            .isConfirmPasswordValid.value
                        ? null
                        : contractorSignUpScreenController.confirmPasswordErrorMessage,
                    visibilityButton: () {
                      contractorSignUpScreenController.chageConfirmShowPassword();
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
                      if (contractorSignUpScreenController.isFirstPageValid()) {
                        Get.to(() => ContractorAdditionalInfoScreen());
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
