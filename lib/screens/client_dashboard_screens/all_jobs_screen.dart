import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/app_state_controller.dart';
import 'package:flutter_project_labour_app/controllers/contractor_job_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/contractor_apply_job_card.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/contractor_apply_job_popup.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/search_jobs_textfield.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/user_search_image.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/filter_popup.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/home_screen_appbar.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_card.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_search_bar.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllJobsScreen extends StatelessWidget {
  AllJobsScreen({super.key});

  final searchTextController = TextEditingController();
  final appStateController = Get.put(AppStateController());
  final contractorJobController = Get.find<ContractorJobController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              onChanged: (String? value) {
                if (value != null && value.trim().isNotEmpty) {
                  contractorJobController.searchJobs(value);
                } else {
                  contractorJobController.allJobsFiltered.clear();
                  contractorJobController.allJobsFiltered.addAll(
                    contractorJobController.allJobs,
                  );
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
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: contractorJobController.allJobsFiltered.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ContractorApplyJobCard(
                      job: contractorJobController.allJobsFiltered[index],
                      onTap: () {
                        contractorApplyJobPopup(
                          context,
                          contractorJobController.allJobsFiltered[index],
                          contractorJobController,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
