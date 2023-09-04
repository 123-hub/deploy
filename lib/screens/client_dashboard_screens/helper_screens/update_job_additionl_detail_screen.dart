import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_job_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/client_dashboard_screen.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/contractor_back_appbar_with_label.dart';
import 'package:flutter_project_labour_app/screens/common/next_button.dart';
import 'package:flutter_project_labour_app/screens/common/skill_capsul.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateJobAdditionalDetailsScreen extends StatelessWidget {
  UpdateJobAdditionalDetailsScreen({required this.id, super.key});
  final int id;
  final contractorJobController = Get.find<ContractorJobController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      ClientBackAppBarWithLabel(
                        label: 'Create Job',
                        toHomeScreen: false,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      TextField(
                        textInputAction: TextInputAction.go,
                        controller: contractorJobController.skillTextController,
                        onSubmitted: (String? value) {
                          if (value != null) {
                            contractorJobController.addSkill(value);
                            contractorJobController.skillTextController.clear();
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: searchBarColor,
                          hintText: 'Enter Skill required',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () {
                              var value = contractorJobController
                                  .skillTextController.text;
                              if (value.isNotEmpty) {
                                contractorJobController.addSkill(value);
                                contractorJobController.skillTextController
                                    .clear();
                              }
                            },
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.w),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.r),
                            borderSide: BorderSide.none, // No border
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Obx(() {
                        return Wrap(
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          spacing: 10,
                          children: contractorJobController.skills
                              .map(
                                (String element) => SkillCapsule(
                                  name: element,
                                  onDelete: () {
                                    contractorJobController
                                        .removeSkill(element);
                                  },
                                ),
                              )
                              .toList(),
                        );
                      }),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        'Description',
                        style: authInfoHeading,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Obx(
                        () {
                          return TextFormField(
                            textInputAction: TextInputAction.go,
                            controller: contractorJobController
                                .descriptionTextController,
                            minLines: 5,
                            maxLines: 10,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: searchBarColor,
                              errorText: contractorJobController
                                      .isDescriptionValid.value
                                  ? null
                                  : contractorJobController.descriptionMessage,
                              hintText: 'Enter Description',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 20.h,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11.r),
                                borderSide: BorderSide.none, // No border
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 30.h,
                right: 30.w,
                child: NextButton(
                  text: 'Update',
                  isArrowPresent: true,
                  onPressed: () async {
                    if (contractorJobController.validateSecondPage()) {
                      var success = await contractorJobController.updateJob(id);
                      if (success) {
                        Get.offAll(() => ClientDashboardScreen());
                        showDoneSnackBar('Job Updated Successfully');
                      } else {
                        showErrorSnackBar('Some Problem occured');
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
