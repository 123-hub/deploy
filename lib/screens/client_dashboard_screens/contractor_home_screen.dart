import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_job_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/contractor_job_card.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/helper_screens/update_job_screen.dart';
import 'package:flutter_project_labour_app/screens/common/progress_hud.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/home_screen_appbar.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_search_bar.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';

class ContractorHomeScreen extends StatelessWidget {
  ContractorHomeScreen({super.key});
  final searchTextController = TextEditingController();
  final contractorJobController = Get.find<ContractorJobController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ProgressHud(
        inAsyncCall: contractorJobController.isLoading.value,
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
                  onTap: () {},
                  readOnly: false,
                ),
                SizedBox(
                  height: 17.h,
                ),
                Text(
                  'All Jobs',
                  style: gilroy18sp,
                ),
                SizedBox(
                  height: 17.h,
                ),
                Obx(() {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: contractorJobController.allJobs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FocusedMenuHolder(
                        onPressed: () {},
                        menuWidth: MediaQuery.of(context).size.width - 66.w,
                        menuOffset: 20.h,
                        menuItemExtent: 50.h,
                        menuItems: [
                          FocusedMenuItem(
                            title: Text(
                              'Edit',
                              style: gilroy16sp,
                            ),
                            trailingIcon: const Icon(Icons.edit_outlined),
                            onPressed: () {
                              contractorJobController.updateJobData(
                                contractorJobController.allJobs[index],
                              );
                              Get.to(
                                () => UpdateJobScreen(
                                  id: contractorJobController.allJobs[index].id,
                                ),
                              );
                            },
                          ),
                          FocusedMenuItem(
                            title: Text(
                              'Delete',
                              style: gilroy16sp.copyWith(color: Colors.white),
                            ),
                            trailingIcon: const Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.red,
                            onPressed: () {
                              contractorJobController.deleteJob(
                                contractorJobController.allJobs[index].id,
                              );
                            },
                          )
                        ],
                        child: ContractorJobCard(
                          job: contractorJobController.allJobs[index],
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
