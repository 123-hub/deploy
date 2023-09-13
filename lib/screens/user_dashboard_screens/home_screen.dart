import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/app_state_controller.dart';
import 'package:flutter_project_labour_app/controllers/apply_job_controller.dart';
import 'package:flutter_project_labour_app/controllers/labour_dashboard_controller.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/filter_popup.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/home_screen_appbar.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_card.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_description_popup.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_search_bar.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final searchTextController = TextEditingController();
  final appStateController = Get.put(AppStateController());
  final applyJobController = Get.find<ApplyJobController>();
  final dashboardController = Get.find<LabourDashboardController>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await applyJobController.getAllJobs();
      },
      child: SingleChildScrollView(
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
              JobSearchBar(
                searchTextController: searchTextController,
                onTap: () {
                  applyJobController.searchedJobs.clear();
                  // dashboardController.changeDashboardScreen(1);
                },
                readOnly: true,
              ),
              SizedBox(
                height: 17.h,
              ),
              Row(
                children: [
                  Material(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      side: const BorderSide(width: 2),
                    ),
                    child: InkWell(
                      onTap: () async {
                        filterPopUp(context, appStateController);
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
                    width: 11.w,
                  ),
                  Material(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      side: const BorderSide(width: 2),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 9.h, horizontal: 12.w),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.attach_money,
                            color: primeryRed,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'Salary : \$10 - \$100',
                            style: tileHeader,
                          )
                        ],
                      ),
                    ),
                  )
                ],
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
              Obx(() {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: applyJobController.allJobs.length,
                  itemBuilder: (BuildContext context, int index) {
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
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
