import 'package:flutter/widgets.dart';
import 'package:flutter_project_labour_app/controllers/apply_job_controller.dart';
import 'package:flutter_project_labour_app/controllers/labour_dashboard_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/search_jobs_textfield.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/applied_job_popup.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/back_appbar.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/empty_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_card_without_tag.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppliedJobsScreen extends StatelessWidget {
  AppliedJobsScreen({super.key});

  final applyJobController = Get.find<ApplyJobController>();
  final dashBoardController = Get.find<LabourDashboardController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 33.w),
      child: Obx(
        () {
          return applyJobController.appliedJobs.isEmpty
              ? const EmptyScreen(
                  image: 'assets/images/empty_jobs.png',
                  title: 'No Applied Jobs',
                  subtitle: 'Get Started By Searching for New Roles',
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      BackAppBar(),
                      SizedBox(
                        height: 27.h,
                      ),
                      JobSearchTextField(
                        onSearch: (String? value) {
                          if (value != null) {
                            applyJobController.searchAppliedJobs(value);
                          }
                        },
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      Text(
                        'Applied Jobs',
                        style: gilroy18sp,
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      Obx(
                        () {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: applyJobController.appliedJobSearchResult.length,
                            itemBuilder: (BuildContext context, int index) {
                              var job = applyJobController.appliedJobSearchResult[index];
                              return JobCardWithoutTag(
                                job: job,
                                onTap: () {
                                  appliedJobPopUp(
                                    context,
                                    job,
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
        },
      ),
    );
  }
}
