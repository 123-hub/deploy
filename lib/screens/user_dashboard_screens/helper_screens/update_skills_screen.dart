import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/labour_profile_controller.dart';
import 'package:flutter_project_labour_app/screens/common/skill_capsul.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/add_skill_text_field.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateSkillsScreen extends StatelessWidget {
  UpdateSkillsScreen({super.key});
  final profileController = Get.find<LabourProfileController>();
  final skillTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 33.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                    Image.asset(
                      'assets/images/notification.png',
                      height: 25.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                AddSkillTextField(
                  skillTextController: skillTextController,
                  onTap: () {
                    var isSuccessful =
                        profileController.addSkill(skillTextController.text);
                    if (isSuccessful) {
                      skillTextController.clear();
                    }
                  },
                  onSubmit: (String? value) {
                    if (value != null && value.isNotEmpty) {
                      var isSuccessful =
                          profileController.addSkill(skillTextController.text);
                      if (isSuccessful) {
                        skillTextController.clear();
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                Obx(() {
                  return Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: profileController.skills
                        .map(
                          (String element) => SkillCapsule(
                            name: element,
                            onDelete: () {
                              profileController.deleteSkill(element);
                            },
                          ),
                        )
                        .toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Obx(() {
        return profileController.isUpdating.value
            ? FloatingActionButton(
                onPressed: () {},
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : FloatingActionButton(
                onPressed: () async {
                  profileController.changeIsUpdating(true);
                  profileController.labourProfile.value!.tradeType.clear();
                  profileController.labourProfile.value!.tradeType
                      .addAll(profileController.skills);
                  bool result = await profileController.updateProfile();
                  profileController.changeIsUpdating(false);
                  if (result) {
                    Get.back();
                  } else {
                    showErrorSnackBar('Some problem occured while updating');
                  }
                  Get.back();
                },
                child: const Icon(Icons.save),
              );
      }),
    );
  }
}
