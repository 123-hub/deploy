import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/labour_profile_controller.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/back_appbar.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/document_card.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/license_card.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/update_profile_popup.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/work_experience_card.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/helper_screens/update_document_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/helper_screens/update_experience_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/helper_screens/update_licenses_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/helper_screens/update_skills_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/parce_date.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final profileController = Get.find<LabourProfileController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 33.w),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              BackAppBar(),
              SizedBox(
                height: 30.h,
              ),
              CircleAvatar(
                radius: 48.r,
                backgroundImage:
                    const AssetImage('assets/images/profile_2.png'),
              ),
              SizedBox(
                height: 26.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${profileController.labourProfile.value!.firstName} ${profileController.labourProfile.value!.lastName}',
                    style: gilroy18sp,
                  ),
                  IconButton(
                    onPressed: () {
                      updateProfilePopUp(context, profileController);
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 20.h,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                profileController.labourProfile.value!.email,
                style: chatTileMessage,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.cake,
                    size: 15.h,
                    color: cardSubtitle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    parceDate(profileController.labourProfile.value!.dob),
                    style: subtitle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: cardSubtitle,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  const Text(
                    '●',
                    style: TextStyle(color: cardSubtitle),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    profileController.labourProfile.value!.phoneNumber,
                    style: subtitle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: cardSubtitle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Text(
                    'Expected Wage:',
                    style: tileHeader.copyWith(color: aboutGrey),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    '\$${profileController.labourProfile.value!.expectedHourRate}/hr:',
                    style: tileHeader.copyWith(
                        color: aboutGrey, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Skills',
                    style: tileHeader.copyWith(color: aboutGrey),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(() => UpdateSkillsScreen());
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 20.h,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Wrap(
                spacing: 10,
                children: [
                  for (int i = 0;
                      i <
                          profileController
                              .labourProfile.value!.tradeType.length;
                      i++)
                    Chip(
                      label: Text(
                        profileController.labourProfile.value!.tradeType[i],
                        style: subtitle.copyWith(color: Colors.black),
                      ),
                      backgroundColor: i % 2 == 0 ? lightBlue : searchBarColor,
                    )
                ],
              ),
              SizedBox(
                height: 13.h,
              ),
              const Divider(),
              SizedBox(
                height: 13.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Work Experience',
                    style: tileHeader.copyWith(color: aboutGrey),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(() => UpdateExperienceScreen());
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 20.h,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    profileController.labourProfile.value!.experience.length,
                itemBuilder: (BuildContext context, int index) {
                  return WorkExperienceCard(
                    experience: profileController
                        .labourProfile.value!.experience[index],
                  );
                },
              ),
              const Divider(),
              SizedBox(
                height: 13.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Licenses',
                    style: tileHeader.copyWith(color: aboutGrey),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(() => UpdateLicenseScreen());
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 20.h,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    profileController.labourProfile.value!.licenses.length,
                itemBuilder: (BuildContext context, int index) {
                  return LicenseCard(
                    license:
                        profileController.labourProfile.value!.licenses[index],
                  );
                },
              ),
              const Divider(),
              SizedBox(
                height: 13.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Documents',
                    style: tileHeader.copyWith(color: aboutGrey),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(() => UpdateDocumentScreen());
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 20.h,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    profileController.labourProfile.value!.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProfileDocumentCard(
                    document:
                        profileController.labourProfile.value!.documents[index],
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          );
        }),
      ),
    );
  }
}
