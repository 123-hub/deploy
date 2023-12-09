import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_job_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/contractor_job_card.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/job_desc_popup_with_applicants.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/helper_screens/update_job_screen.dart';
import 'package:flutter_project_labour_app/screens/common/progress_hud.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/home_screen_appbar.dart';
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
    var size = MediaQuery.of(context).size;
    return Obx(
      () {
        return ProgressHud(
          inAsyncCall: contractorJobController.isLoading.value,
          child: contractorJobController.myJobs.isEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          const HomeScreenAppBar(),
                          SizedBox(
                            height: size.height / 5.5,
                          ),
                          Image.asset('assets/images/empty_jobs.png'),
                          Text(
                            'No Jobs postings by you',
                            style: emptyPageTitle,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'Add jobs to display here',
                            style: emptyPageSubTitle,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
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
                        // JobSearchBar(
                        //   searchTextController: searchTextController,
                        //   onTap: () {},
                        //   readOnly: false,
                        // ),
                        // SizedBox(
                        //   height: 17.h,
                        // ),
                        Text(
                          'My Job Postings',
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
                              itemCount: contractorJobController.myJobs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FocusedMenuHolder(
                                  onPressed: () {
                                    contractorJobDescriptionWithApplicantsPopUp(
                                      context,
                                      contractorJobController.myJobs[index],
                                      contractorJobController,
                                    );
                                  },
                                  menuWidth:
                                      MediaQuery.of(context).size.width - 66.w,
                                  menuOffset: 20.h,
                                  menuItemExtent: 50.h,
                                  menuItems: [
                                    FocusedMenuItem(
                                      title: Text(
                                        'Edit',
                                        style: gilroy16sp,
                                      ),
                                      trailingIcon:
                                          const Icon(Icons.edit_outlined),
                                      onPressed: () {
                                        contractorJobController.updateJobData(
                                          contractorJobController.myJobs[index],
                                        );
                                        Get.to(
                                          () => UpdateJobScreen(
                                            id: contractorJobController
                                                .myJobs[index].id,
                                          ),
                                        );
                                      },
                                    ),
                                    FocusedMenuItem(
                                      title: Text(
                                        'Delete',
                                        style: gilroy16sp.copyWith(
                                            color: Colors.white),
                                      ),
                                      trailingIcon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Colors.red,
                                      onPressed: () {
                                        contractorJobController.deleteJob(
                                          contractorJobController
                                              .myJobs[index].id,
                                        );
                                      },
                                    )
                                  ],
                                  child: ContractorJobCard(
                                    job: contractorJobController.myJobs[index],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
