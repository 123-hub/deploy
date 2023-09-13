import 'package:flutter/widgets.dart';
import 'package:flutter_project_labour_app/controllers/apply_job_controller.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/applied_job_popup.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/back_appbar.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/empty_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_card_without_tag.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppliedJobsScreen extends StatelessWidget {
  AppliedJobsScreen({super.key});

  final searchTextController = TextEditingController();
  final applyJobController = Get.find<ApplyJobController>();

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
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      BackAppBar(),
                      SizedBox(
                        height: 27.h,
                      ),
                      JobSearchBar(
                        searchTextController: searchTextController,
                        readOnly: false,
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      Obx(
                        () {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: applyJobController.appliedJobs.length,
                            itemBuilder: (BuildContext context, int index) {
                              var job = applyJobController.appliedJobs[index];
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
