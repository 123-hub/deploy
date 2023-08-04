import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/app_state_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_appbar.dart';
import 'package:flutter_project_labour_app/screens/common/next_button.dart';
import 'package:flutter_project_labour_app/screens/common/skill_capsul.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/add_skill_text_field.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/age_slider.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/gender_drop_down_menu.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/normal_text_field.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/signup_complete_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdditionalInfoScreen extends StatelessWidget {
  AdditionalInfoScreen({super.key});
  final appStateController = Get.put(AppStateController());
  final locationTextController = TextEditingController();
  final skillTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 37.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    const AuthAppBar(),
                    SizedBox(
                      height: 71.h,
                    ),
                    Text(
                      'Additional Info',
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
                    Text(
                      'Enter your age',
                      style: authInfoHeading,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Obx(
                  () {
                    return AgeSlider(
                      value: appStateController.sliderValue.value,
                      onChanged: appStateController.onSliderChanged,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 37.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 49.h,
                    ),
                    Text(
                      'Gender',
                      style: authInfoHeading,
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Obx(
                      () {
                        return GenderDropDownMenu(
                          value: appStateController.gender.value,
                          onChanged: appStateController.onGenderChange,
                        );
                      },
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      'Location',
                      style: authInfoHeading,
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    NormalTextField(
                      locationTextController: locationTextController,
                      hint: 'Enter Location',
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      'Add Skills',
                      style: authInfoHeading,
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Obx(() {
                      return Wrap(
                        direction: Axis.horizontal,
                        spacing: 10,
                        children: appStateController.skills
                            .map(
                              (String element) => SkillCapsule(
                                name: element,
                                onDelete: () {
                                  appStateController.deleteSkill(element);
                                },
                              ),
                            )
                            .toList(),
                      );
                    }),
                    SizedBox(
                      height: 14.h,
                    ),
                    AddSkillTextField(
                      skillTextController: skillTextController,
                      onTap: () {
                        var isSuccessful = appStateController
                            .addSkill(skillTextController.text);
                        if (isSuccessful) {
                          skillTextController.clear();
                        }
                      },
                      onSubmit: (String? value) {
                        if (value != null && value.isNotEmpty) {
                          var isSuccessful = appStateController
                              .addSkill(skillTextController.text);
                          if (isSuccessful) {
                            skillTextController.clear();
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 150.h,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: NextButton(
                        text: 'Next',
                        isArrowPresent: true,
                        onPressed: () {
                          Get.offAll(() => const SignUpComplete());
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
