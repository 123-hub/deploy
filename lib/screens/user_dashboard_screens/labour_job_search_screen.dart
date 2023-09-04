import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/apply_job_controller.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/back_appbar.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_card.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_description_popup.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LabourJobSearchScreen extends StatelessWidget {
  LabourJobSearchScreen({super.key});
  final applyJobController = Get.find<ApplyJobController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 33.w),
      child: Obx(() {
        return applyJobController.searchedJobs.isEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    BackAppBar(),
                    SizedBox(
                      height: 27.h,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        readOnly: false,
                        autofocus: true,
                        onChanged: (String? value) {
                          if (value != null) {
                            applyJobController.searchJob(value);
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: searchBarColor,
                          contentPadding: EdgeInsets.only(bottom: 5.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.r),
                            borderSide: BorderSide.none, // No border
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: searchBarIconColor,
                          ),
                          suffixIcon: const Icon(
                            Icons.mic,
                            color: searchBarIconColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 7,
                    ),
                    Image.asset('assets/images/empty_jobs.png'),
                    Text(
                      'No Results Found',
                      style: emptyPageTitle,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Type something to search',
                      style: emptyPageSubTitle,
                    )
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    BackAppBar(),
                    SizedBox(
                      height: 27.h,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        readOnly: false,
                        autofocus: true,
                        onChanged: (String? value) {
                          if (value != null) {
                            applyJobController.searchJob(value);
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: searchBarColor,
                          contentPadding: EdgeInsets.only(bottom: 5.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.r),
                            borderSide: BorderSide.none, // No border
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: searchBarIconColor,
                          ),
                          suffixIcon: const Icon(
                            Icons.mic,
                            color: searchBarIconColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    Obx(
                      () {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: applyJobController.searchedJobs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return JobCard(
                              job: applyJobController.searchedJobs[index],
                              onTap: () {
                                jobDescriptionPopUp(
                                  context,
                                  applyJobController.searchedJobs[index],
                                  applyJobController,
                                );
                              },
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              );
      }),
    );
  }
}
