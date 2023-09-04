import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/apply_job_controller.dart';
import 'package:flutter_project_labour_app/controllers/contractor_dashboard_controller.dart';
import 'package:flutter_project_labour_app/controllers/contractor_job_controller.dart';
import 'package:flutter_project_labour_app/controllers/contractor_profile_controller.dart';
import 'package:flutter_project_labour_app/controllers/labour_dashboard_controller.dart';
import 'package:flutter_project_labour_app/controllers/labour_profile_controller.dart';
import 'package:flutter_project_labour_app/controllers/login_screen_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/client_dashboard_screen.dart';
import 'package:flutter_project_labour_app/screens/common/auth_appbar.dart';
import 'package:flutter_project_labour_app/screens/common/auth_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/progress_hud.dart';
import 'package:flutter_project_labour_app/screens/common/role_drop_down_menu.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/role_signup_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/dashboard_screen.dart';
import 'package:flutter_project_labour_app/screens/login_screens/components/social_login_button.dart';
import 'package:flutter_project_labour_app/screens/login_screens/components/social_login_divider.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final loginScreenController = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        return ProgressHud(
          inAsyncCall: loginScreenController.isLoading.value,
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  SingleChildScrollView(
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
                              errorText:
                                  loginScreenController.isEmailValid.value
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
                              showPassword:
                                  loginScreenController.showPassword.value,
                              textInputType: TextInputType.visiblePassword,
                              errorText: loginScreenController
                                      .isPasswordValid.value
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
                                showErrorSnackBar("Feature coming soon");
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
                              loginScreenController.changeIsLoading(true);
                              FocusManager.instance.primaryFocus?.unfocus();
                              var isValid =
                                  loginScreenController.areTextFieldValid();
                              debugPrint('Are text field Valid: $isValid');
                              if (isValid) {
                                await loginScreenController.loginUser();
                                if (loginScreenController.loginResponse.value !=
                                    null) {
                                  debugPrint('Login Succesfull');
                                  if (loginScreenController.role.value ==
                                      'labour') {
                                    var labourProfileController = Get.put(
                                      LabourProfileController(),
                                      permanent: true,
                                    );
                                    var status = await labourProfileController
                                        .getProfile();
                                    var applyJobController = Get.put(
                                      ApplyJobController(),
                                      permanent: true,
                                    );
                                    var dashboardController = Get.put(
                                      LabourDashboardController(),
                                      permanent: true,
                                    );
                                    await applyJobController.getAllJobs();
                                    await applyJobController.getAppliedJobs();
                                    await applyJobController.getSavedJobs();
                                    if (status) {
                                      Get.off(() => DashboardScreen());
                                    } else {
                                      showErrorSnackBar(
                                        'Some Error occured while fetching your profile',
                                      );
                                    }
                                  } else {
                                    var contractorProfileController = Get.put(
                                      ContractorProfileController(),
                                      permanent: true,
                                    );
                                    var dashboardController = Get.put(
                                      ContractorDashboardController(),
                                      permanent: true,
                                    );
                                    var contractorJobController = Get.put(
                                      ContractorJobController(),
                                      permanent: true,
                                    );
                                    var status =
                                        await contractorProfileController
                                            .getProfile();
                                    await contractorJobController.getJobs();
                                    if (status) {
                                      Get.off(() => ClientDashboardScreen());
                                    } else {
                                      showErrorSnackBar(
                                        'Some Error occured while fetching your profile',
                                      );
                                    }
                                  }
                                } else {
                                  debugPrint('facing problem');
                                }
                              }
                              loginScreenController.changeIsLoading(false);
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
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom: 20.h,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
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
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
