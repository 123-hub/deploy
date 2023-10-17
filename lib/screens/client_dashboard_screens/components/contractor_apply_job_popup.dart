import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_job_controller.dart';
import 'package:flutter_project_labour_app/models/job.dart';
import 'package:flutter_project_labour_app/screens/common/job_desc_tile.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<dynamic> contractorApplyJobPopup(
    BuildContext context, Job job, ContractorJobController applyJobController) {
  // bool hasApplied = applyJobController.isPresentInAppliedJobs(job.id);
  // applyJobController.isPresentInSavedJobs(job.id);
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
                // Text(
                //   'Preferred  Experience',
                //   style: gilroy12_600.copyWith(color: jobDescTileTextGrey),
                // ),
                // SizedBox(
                //   height: 9.h,
                // ),
                // const UnorderedList([
                //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed amet, consectetur adipiscing, tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut',
                //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed amet, consectetur adipiscing',
                //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed amet, consectetur adipiscing',
                // ]),
                // SizedBox(
                //   height: 21.h,
                // ),
                // const Divider(),
                // SizedBox(
                //   height: 19.h,
                // ),
                // Text(
                //   'Company Info',
                //   style: gilroy12_600.copyWith(color: jobDescTileTextGrey),
                // ),
                // SizedBox(
                //   height: 9.h,
                // ),
                // const CompanyInfoTile(
                //   title: 'Website',
                //   value: 'www.larsentoubro.com',
                // ),
                // SizedBox(
                //   height: 13.h,
                // ),
                // const CompanyInfoTile(
                //   title: 'Founded',
                //   value: '2018',
                // ),
                // SizedBox(
                //   height: 13.h,
                // ),
                // const CompanyInfoTile(
                //   title: 'Size',
                //   value: '400 Employee',
                // ),
                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          ),
          job.status == 'CLOSED'
              ? Positioned.fill(
                  bottom: 24.h,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      minWidth: MediaQuery.of(context).size.width * 0.80,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      color: primaryRed,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Text(
                          'Job Expired',
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Positioned(
                  bottom: 24.h,
                  child: Obx(
                    () {
                      return applyJobController.isApplying.value
                          ? MaterialButton(
                              onPressed: () {},
                              minWidth:
                                  MediaQuery.of(context).size.width * 0.84,
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
                          // : hasApplied
                          //     ? MaterialButton(
                          //         onPressed: () async {
                          //           bool result = await applyJobController
                          //               .deleteApplication(job.id);
                          //           if (result) {
                          //             Navigator.pop(context);
                          //             showDoneSnackBar(
                          //                 "Application withdrawn");
                          //           } else {
                          //             showErrorSnackBar(
                          //               "Some error occured while withdrawing the application",
                          //             );
                          //           }
                          //         },
                          //         minWidth:
                          //             MediaQuery.of(context).size.width *
                          //                 0.65,
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius:
                          //               BorderRadius.circular(8.r),
                          //         ),
                          //         color: primaryRed,
                          //         child: Padding(
                          //           padding: EdgeInsets.symmetric(
                          //               vertical: 15.h),
                          //           child: Text(
                          //             'Withdraw Application',
                          //             style: TextStyle(
                          //               fontSize: 17.sp,
                          //               fontFamily: 'Gilroy',
                          //               fontWeight: FontWeight.w600,
                          //               color: Colors.white,
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          : MaterialButton(
                              onPressed: () async {
                                if (job.status == 'AVAILABLE') {
                                  // var status = await applyJobController
                                  //     .applyJob(job.id);
                                  // debugPrint(status.toString());
                                  // if (status) {
                                  //   showDoneSnackBar(
                                  //     'Applied for the job of ${job.name}',
                                  //   );
                                  //   Navigator.pop(context);
                                  // } else {
                                  //   showErrorSnackBar(
                                  //     'Some problem occured while apply for job',
                                  //   );
                                  // }
                                  var bidAmountController =
                                      TextEditingController();
                                  await showDialog<int>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Adjust the border radius as needed
                                        ),
                                        title: const Text('Place a Bid'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            TextField(
                                              controller: bidAmountController,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                hintText:
                                                    'Enter your bid amount',
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 40.h,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  var amount =
                                                      bidAmountController.text
                                                          .trim();
                                                  if (amount.isNotEmpty) {
                                                    Navigator.pop(
                                                      context,
                                                    );
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: primaryRed,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                                child: Text('Bid'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  applyJobController.changeIsApplying(true);
                                  var result =
                                      await applyJobController.applyJob(
                                    job.id,
                                    int.parse(
                                      bidAmountController.text.trim(),
                                    ),
                                  );
                                  applyJobController.changeIsApplying(false);
                                  if (result) {
                                    Navigator.pop(context);
                                    showDoneSnackBar("Applied");
                                  } else {
                                    showErrorSnackBar(
                                      "Was not able to apply",
                                    );
                                  }
                                } else {
                                  showErrorSnackBar(
                                    'Job Unavailable to apply',
                                  );
                                }
                              },
                              minWidth:
                                  MediaQuery.of(context).size.width * 0.84,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              color: const Color(0xFFFF4E34),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                                child: Text(
                                  'Apply For This Job',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
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