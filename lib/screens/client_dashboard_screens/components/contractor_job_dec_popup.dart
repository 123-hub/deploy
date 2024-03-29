import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_job_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/client_dashboard_screen.dart';
import 'package:flutter_project_labour_app/screens/common/job_desc_tile.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<dynamic> contractorJobDescriptionPopUp(
    BuildContext context, ContractorJobController contractorJobController) {
  var job = contractorJobController.getJobData();
  return showModalBottomSheet(
    useSafeArea: true,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.symmetric(horizontal: 33.w),
      height: MediaQuery.of(context).size.height * 0.85,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.work_outline,
                      size: 80.h,
                      color: aboutGrey,
                    ),
                    SizedBox(
                      width: 39.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.name,
                          style: authInfoHeading.copyWith(color: subtitleGrey),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          job.enterLocation,
                          style: subtitle.copyWith(color: cardSubtitle),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 29.h,
                ),
                Container(
                  height: 104.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: searchBarColor),
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      JobDescTile(
                        icon: Icons.work_outline,
                        text: job.duration,
                      ),
                      VerticalDivider(
                        indent: 15.h,
                        endIndent: 15.h,
                      ),
                      // JobDescTile(
                      //   icon: Icons.attach_money,
                      //   text: '\$${job.salaryRange}/month',
                      // ),
                      // VerticalDivider(
                      //   indent: 15.h,
                      //   endIndent: 15.h,
                      // ),
                      JobDescTile(
                        icon: Icons.location_on_outlined,
                        text: job.enterLocation,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  'Description',
                  style: gilroy12_600.copyWith(color: jobDescTileTextGrey),
                ),
                SizedBox(
                  height: 9.h,
                ),
                Text(
                  job.description,
                  style: gilroy12_400.copyWith(
                    color: aboutGrey,
                  ),
                ),
                SizedBox(
                  height: 21.h,
                ),
                const Divider(),
                SizedBox(
                  height: 19.h,
                ),
                Text(
                  'Qualifications',
                  style: gilroy12_600.copyWith(color: jobDescTileTextGrey),
                ),
                SizedBox(
                  height: 9.h,
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    for (int i = 0; i < job.skills.length; i++)
                      Chip(
                        label: Text(
                          job.skills[i],
                          style: subtitle.copyWith(color: Colors.black),
                        ),
                        backgroundColor:
                            i % 2 == 0 ? lightBlue : searchBarColor,
                      )
                  ],
                ),
                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          ),
          Positioned.fill(
            bottom: 24.h,
            child: Obx(
              () {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: contractorJobController.isLoading.value
                      ? MaterialButton(
                          onPressed: () {},
                          minWidth: MediaQuery.of(context).size.width * 0.8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          color: const Color(0xFFFF4E34),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : MaterialButton(
                          onPressed: () async {
                            contractorJobController.changeLoading(true);
                            var status =
                                await contractorJobController.createJob();
                            if (status) {
                              Navigator.pop(context);
                              Get.offAll(() => ClientDashboardScreen());
                            } else {
                              showErrorSnackBar('Something went Wrong');
                            }
                            contractorJobController.changeLoading(false);
                          },
                          minWidth: MediaQuery.of(context).size.width * 0.8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          color: const Color(0xFFFF4E34),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            child: Text(
                              'Publish Job',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
