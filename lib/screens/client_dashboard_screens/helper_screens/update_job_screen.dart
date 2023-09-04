import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_job_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/contractor_back_appbar_with_label.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/create_job_text_field.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/helper_screens/update_job_additionl_detail_screen.dart';
import 'package:flutter_project_labour_app/screens/common/next_button.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateJobScreen extends StatelessWidget {
  UpdateJobScreen({
    required this.id,
    super.key,
  });

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
                      ClientBackAppBarWithLabel(label: 'Create Job'),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        'Job Name',
                        style: authInfoHeading,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Obx(() {
                        return CreateJobTextField(
                          controller:
                              contractorJobController.jobNameTextController,
                          hint: 'Enter Job Name',
                          errorText:
                              contractorJobController.isJobNameValid.value
                                  ? null
                                  : contractorJobController.jobNameMessage,
                        );
                      }),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        'Job Type',
                        style: authInfoHeading,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Obx(() {
                        return CreateJobTextField(
                          controller:
                              contractorJobController.jobTypeTextController,
                          hint: 'Enter Job Type',
                          errorText:
                              contractorJobController.isJobTypeValid.value
                                  ? null
                                  : contractorJobController.jobTypeMessage,
                        );
                      }),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        'Salary Range',
                        style: authInfoHeading,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Obx(() {
                        return CreateJobTextField(
                          controller:
                              contractorJobController.salaryRangeTextController,
                          hint: 'Enter Salary Range',
                          textInputType: TextInputType.number,
                          errorText:
                              contractorJobController.isSalaryRangeValid.value
                                  ? null
                                  : contractorJobController.salaryRangeMessage,
                        );
                      }),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        'Location',
                        style: authInfoHeading,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Obx(() {
                        return CreateJobTextField(
                          controller:
                              contractorJobController.locationTextController,
                          hint: 'Enter location',
                          errorText:
                              contractorJobController.islocationValid.value
                                  ? null
                                  : contractorJobController.locationMessage,
                        );
                      }),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        'Job Duration',
                        style: authInfoHeading,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Obx(() {
                              return CreateJobTextField(
                                controller: contractorJobController
                                    .durationTextController,
                                hint: 'Enter duration',
                                textInputType: TextInputType.number,
                                errorText: contractorJobController
                                        .isdurationValid.value
                                    ? null
                                    : contractorJobController.durationMessage,
                              );
                            }),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            flex: 1,
                            child: Obx(() {
                              return DropdownButton<String>(
                                value: contractorJobController.duration.value,
                                isExpanded: true,
                                style: tileHeader,
                                underline: const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: aboutGrey,
                                ),
                                icon: Material(
                                  color: Colors.transparent,
                                  shape: const CircleBorder(
                                    side: BorderSide(
                                        color: Colors.black, width: 2),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.arrow_downward,
                                      color: Colors.black,
                                      size: 13.sp,
                                    ),
                                  ),
                                ),
                                hint: Text(
                                  'Duration',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                items: ['days', 'months', 'years']
                                    .map(
                                      (String value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value.capitalize!),
                                      ),
                                    )
                                    .toList(),
                                onChanged:
                                    contractorJobController.changeDuration,
                              );
                            }),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
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
                  onPressed: () {
                    if (contractorJobController.validateFirstPage()) {
                      Get.to(
                        () => UpdateJobAdditionalDetailsScreen(
                          id: id,
                        ),
                      );
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
