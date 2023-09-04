import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/labour_signup_screen_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_appbar.dart';
import 'package:flutter_project_labour_app/screens/common/next_button.dart';
import 'package:flutter_project_labour_app/screens/common/progress_hud.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/add_document.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/add_experience_card.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/add_experience_popup.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/add_license_popup.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/labour_license_card.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/signup_complete_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LabourExperienceScreen extends StatelessWidget {
  LabourExperienceScreen({super.key});
  final signupScreenController = Get.find<LabourSignupScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        return ProgressHud(
          inAsyncCall: signupScreenController.isCreatingID.value,
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
                            height: 30.h,
                          ),
                          Text(
                            'Experience Details',
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
                            height: 36.h,
                          ),
                          AddDocument(
                            title: 'Add Experience',
                            onTap: () {
                              addExperiencePopup(
                                  context, signupScreenController);
                            },
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Obx(() {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  signupScreenController.experiences.length,
                              itemBuilder: (BuildContext context, int index) {
                                var exp =
                                    signupScreenController.experiences[index];
                                return AddExperienceCard(
                                  experience: exp,
                                  onTap: () {
                                    signupScreenController
                                        .deleteExperience(exp);
                                  },
                                );
                              },
                            );
                          }),
                          SizedBox(
                            height: 30.h,
                          ),
                          AddDocument(
                            title: 'Add Licenses',
                            onTap: () {
                              addLicensePopUp(context, signupScreenController);
                            },
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Obx(() {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: signupScreenController.licenses.length,
                              itemBuilder: (BuildContext context, int index) {
                                var lic =
                                    signupScreenController.licenses[index];
                                return LabourLicenseCard(
                                  license: lic,
                                  onTap: () {
                                    signupScreenController.deleteLicense(lic);
                                  },
                                );
                              },
                            );
                          }),
                          SizedBox(
                            height: 100.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30.h,
                    right: 30.w,
                    child: NextButton(
                      text: 'Next',
                      isArrowPresent: true,
                      onPressed: () async {
                        bool success =
                            await signupScreenController.labourSignUp();
                        if (success) {
                          Get.to(() => const SignUpComplete());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

