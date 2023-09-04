import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/apply_job_controller.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/back_appbar.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/empty_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_card_without_tag.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_description_popup.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_search_bar.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class JobBookmarkScreen extends StatelessWidget {
  JobBookmarkScreen({super.key});
  final searchTextController = TextEditingController();
  final applyJobController = Get.find<ApplyJobController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 33.w),
      child: Obx(() {
        return applyJobController.savedJobs.isEmpty
            ? const EmptyScreen(
                image: 'assets/images/empty_jobs.png',
                title: 'No Saved Jobs',
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
                    JobSearchBar(searchTextController: searchTextController,readOnly: false,),
                    SizedBox(
                      height: 17.h,
                    ),
                    Obx(
                      () {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: applyJobController.savedJobs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var job = applyJobController.savedJobs[index];
                            return Slidable(
                              key: ValueKey<int>(index),
                              endActionPane: ActionPane(
                                dragDismissible: false,
                                motion: const BehindMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      applyJobController.deleteSavedJob(job.id);
                                    },
                                    backgroundColor: darkRed,
                                    borderRadius: BorderRadius.circular(11.r),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete_outline,
                                    label: 'Remove',
                                  ),
                                ],
                              ),
                              child: JobCardWithoutTag(
                                job: job,
                                onTap: () {
                                  jobDescriptionPopUp(context, job, applyJobController);
                                },
                              ),
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
