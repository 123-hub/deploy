import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/labour_profile_controller.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/add_experience_card.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/add_profile_experience_popup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateExperienceScreen extends StatelessWidget {
  UpdateExperienceScreen({super.key});
  final profileController = Get.find<LabourProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 33.w),
            child: Column(
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
                Obx(() {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: profileController.experiences.length,
                    itemBuilder: (BuildContext context, int index) {
                      var exp = profileController.experiences[index];
                      return AddExperienceCard(
                        experience: exp.toModel(),
                        onTap: () {
                          profileController.deleteExperience(exp);
                        },
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Get.back();
            },
            child: const Icon(Icons.save),
          ),
          SizedBox(
            width: 20.w,
          ),
          FloatingActionButton(
            heroTag: 'Add',
            onPressed: () {
              addProfileExperiencePopup(context, profileController);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
