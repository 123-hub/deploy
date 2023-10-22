import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_job_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/contractor_apply_job_card.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/contractor_apply_job_popup.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/contractor_job_filter.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/search_jobs_textfield.dart';

import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/home_screen_appbar.dart';

import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllJobsScreen extends StatefulWidget {
  AllJobsScreen({super.key});

  @override
  State<AllJobsScreen> createState() => _AllJobsScreenState();
}

class _AllJobsScreenState extends State<AllJobsScreen> {
  final contractorJobController = Get.find<ContractorJobController>();

  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    contractorJobController.scrollController.addListener(() {
      if (contractorJobController.scrollController.position.pixels ==
          contractorJobController.scrollController.position.maxScrollExtent) {
        if (!contractorJobController.isFetchingJob.value) {
          contractorJobController.isFetchingJob(true);
          contractorJobController.getAllJobsNextPage().then((_) {
            contractorJobController.isFetchingJob(false);
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    searchTextController.text = contractorJobController.searchString;
    return RefreshIndicator(
      onRefresh: () async {
        await contractorJobController.applyFilter();
      },
      child: SingleChildScrollView(
        controller: contractorJobController.scrollController,
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
                    contractorJobController.searchString = value.trim();
                    contractorJobController.applyFilter();
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
                    contractorJobFilter(context, contractorJobController);
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
                'All job postings',
                style: gilroy18sp,
              ),
              SizedBox(
                height: 17.h,
              ),
              Obx(
                () {
                  return contractorJobController.isJobLoading.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: primaryRed,
                            ),
                          ),
                        )
                      : contractorJobController.allJobsFiltered.isEmpty
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
                                  if (!contractorJobController
                                      .isFetchingJob.value) {
                                    contractorJobController.isFetchingJob(true);
                                    contractorJobController
                                        .getAllJobsNextPage()
                                        .then(
                                      (_) {
                                        contractorJobController
                                            .isFetchingJob(false);
                                      },
                                    );
                                  }
                                }
                                return false;
                              },
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: contractorJobController
                                        .allJobsFiltered.length +
                                    1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index <
                                      contractorJobController
                                          .allJobsFiltered.length) {
                                    return ContractorApplyJobCard(
                                      job: contractorJobController
                                          .allJobsFiltered[index],
                                      onTap: () {
                                        contractorApplyJobPopup(
                                          context,
                                          contractorJobController
                                              .allJobsFiltered[index],
                                          contractorJobController,
                                        );
                                      },
                                    );
                                  } else if (contractorJobController
                                          .paginationData.value!.page ==
                                      contractorJobController
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
