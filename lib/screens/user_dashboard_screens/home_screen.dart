import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/apply_job_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/search_jobs_textfield.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/home_screen_appbar.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_card.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_description_popup.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/labour_filter_popup.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchTextController = TextEditingController();

  final applyJobController = Get.find<ApplyJobController>();

  @override
  void initState() {
    applyJobController.scrollController.addListener(() {
      if (applyJobController.scrollController.position.pixels ==
          applyJobController.scrollController.position.maxScrollExtent) {
        if (!applyJobController.isFetchingJob.value) {
          applyJobController.isFetchingJob(true);
          applyJobController.getAllJobsNextPage().then((_) {
            applyJobController.isFetchingJob(false);
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    searchTextController.text = applyJobController.searchString;
    return RefreshIndicator(
      onRefresh: () async {
        await applyJobController.getAllJobs();
      },
      child: SingleChildScrollView(
        controller: applyJobController.scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              const HomeScreenAppBar(),
              SizedBox(
                height: 27.h,
              ),
              JobSearchTextField(
                onSearch: (String? value) {
                  if (value != null && value.trim().isNotEmpty) {
                    applyJobController.searchString = value.trim();
                    applyJobController.applyFilter();
                  } else {
                    applyJobController.searchString = "";
                    applyJobController.applyFilter();
                  }
                },
              ),
              SizedBox(
                height: 17.h,
              ),
              Material(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  side: const BorderSide(width: 2),
                ),
                child: InkWell(
                  onTap: () async {
                    labourJobFilter(context, applyJobController);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    child: Icon(
                      Icons.tune,
                      size: 20.h,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 17.h,
              ),
              Text(
                'Current Listings',
                style: gilroy18sp,
              ),
              SizedBox(
                height: 17.h,
              ),
              // Obx(
              //   () {
              //     return ListView.builder(
              //       physics: const NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       itemCount: applyJobController.allJobs.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return JobCard(
              //           job: applyJobController.allJobs[index],
              //           onTap: () {
              //             jobDescriptionPopUp(
              //               context,
              //               applyJobController.allJobs[index],
              //               applyJobController,
              //             );
              //           },
              //         );
              //       },
              //     );
              //   },
              // ),
              Obx(
                () {
                  return applyJobController.isJobLoading.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: primaryRed,
                            ),
                          ),
                        )
                      : applyJobController.allJobs.isEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  'No Jobs Found',
                                  style: authHeading,
                                ),
                              ),
                            )
                          : NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                                  if (!applyJobController.isFetchingJob.value) {
                                    applyJobController.isFetchingJob(true);
                                    applyJobController
                                        .getAllJobsNextPage()
                                        .then(
                                      (_) {
                                        applyJobController.isFetchingJob(false);
                                      },
                                    );
                                  }
                                }
                                return false;
                              },
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    applyJobController.allJobs.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index <
                                      applyJobController.allJobs.length) {
                                    return JobCard(
                                      job: applyJobController.allJobs[index],
                                      onTap: () {
                                        jobDescriptionPopUp(
                                          context,
                                          applyJobController.allJobs[index],
                                          applyJobController,
                                        );
                                      },
                                    );
                                  } else if (applyJobController
                                          .paginationData.value!.page ==
                                      applyJobController
                                          .paginationData.value!.totalPage) {
                                    return const SizedBox();
                                  } else {
                                    return const Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: CircularProgressIndicator(
                                          color: primaryRed,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
