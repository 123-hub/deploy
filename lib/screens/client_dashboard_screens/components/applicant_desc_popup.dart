import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_chat_controller.dart';
import 'package:flutter_project_labour_app/controllers/contractor_job_controller.dart';
import 'package:flutter_project_labour_app/models/labour_profile.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/contractor_chat_screen.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/contractor_conversation_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/document_card.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/license_card.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/work_experience_card.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/parce_date.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<dynamic> applicantDescriptionPopUp(
  BuildContext context,
  LabourProfile profile,
  int jobId,
  ContractorJobController contractorJobController,
) {
  bool isHired = contractorJobController.isHired(jobId, profile.id);
  final chatController = Get.find<ContractorChatController>();
  return showModalBottomSheet(
    useSafeArea: true,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.symmetric(horizontal: 33.w),
      height: MediaQuery.of(context).size.height * 0.85,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 48.r,
                      backgroundImage:
                          const AssetImage('assets/images/profile_2.png'),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Text(
                      '${profile.firstName} ${profile.lastName}',
                      style: gilroy18sp,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      profile.email,
                      style: chatTileMessage,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          parceDate(profile.dob),
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
                          profile.phoneNumber,
                          style: subtitle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: cardSubtitle,
                          ),
                        ),
                      ],
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
                      '\$${profile.expectedHourRate}/hr:',
                      style: tileHeader.copyWith(
                          color: aboutGrey, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Skills',
                  style: tileHeader.copyWith(color: aboutGrey),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    for (int i = 0; i < profile.tradeType.length; i++)
                      Chip(
                        label: Text(
                          profile.tradeType[i],
                          style: subtitle.copyWith(color: Colors.black),
                        ),
                        backgroundColor:
                            i % 2 == 0 ? lightBlue : searchBarColor,
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
                Text(
                  'Work Experience',
                  style: tileHeader.copyWith(color: aboutGrey),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profile.experience.length,
                  itemBuilder: (BuildContext context, int index) {
                    return WorkExperienceCard(
                      experience: profile.experience[index],
                    );
                  },
                ),
                const Divider(),
                SizedBox(
                  height: 13.h,
                ),
                Text(
                  'Licenses',
                  style: tileHeader.copyWith(color: aboutGrey),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profile.licenses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LicenseCard(
                      license: profile.licenses[index],
                    );
                  },
                ),
                const Divider(),
                SizedBox(
                  height: 13.h,
                ),
                Text(
                  'Documents',
                  style: tileHeader.copyWith(color: aboutGrey),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profile.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProfileDocumentCard(
                      document: profile.documents[index],
                    );
                  },
                ),
                SizedBox(
                  height: 80.h,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 24.h,
            child: Row(
              children: [
                Obx(() {
                  return chatController.isChatLoading.value
                      ? ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () async {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: const CircularProgressIndicator(
                              color: primaryRed,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            var room =
                                await chatController.createRooms(profile.id);
                            if (room != null) {
                              Navigator.pop(context);
                              Get.to(
                                () => ContractorChatScreen(
                                  room: room,
                                ),
                              );
                            } else {
                              showErrorSnackBar("Some problem occurred");
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Icon(
                              Icons.chat_outlined,
                              color: Colors.black,
                              size: 25.h,
                            ),
                          ),
                        );
                }),
                SizedBox(
                  width: 15.w,
                ),
                isHired
                    ? MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        minWidth: MediaQuery.of(context).size.width * 0.65,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        color: Colors.green,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Text(
                            'Hired',
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Obx(() {
                        return contractorJobController.isHiring.value
                            ? MaterialButton(
                                onPressed: () {},
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.65,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                color: const Color(0xFFFF4E34),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.h),
                                  child: const CircularProgressIndicator(
                                      color: Colors.white),
                                ),
                              )
                            : MaterialButton(
                                onPressed: () async {
                                  bool success =
                                      await contractorJobController.hire(
                                    jobId,
                                    profile.id,
                                  );
                                  if (success) {
                                    Get.back();
                                    showDoneSnackBar('Hired this labour');
                                  } else {
                                    showErrorSnackBar('Some Problem Occured');
                                  }
                                },
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.65,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                color: const Color(0xFFFF4E34),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.h),
                                  child: Text(
                                    'Hire For Position',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                      })
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
