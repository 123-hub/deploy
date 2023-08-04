import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/app_state_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/user_search_image.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/filter_popup.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/home_screen_appbar.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_search_bar.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserSearchScreen extends StatelessWidget {
  UserSearchScreen({super.key});

  final searchTextController = TextEditingController();
  final appStateController = Get.put(AppStateController());

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
            JobSearchBar(searchTextController: searchTextController),
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
              'People matching description',
              style: gilroy18sp,
            ),
            SizedBox(
              height: 17.h,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 95.h,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const UserSearchImage(
                        image: 'assets/images/worker.png',
                        rating: 4.2,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Mason Baxter',
                                style:
                                    authInfoHeading.copyWith(color: primeryRed),
                              ),
                              SizedBox(
                                width: 85.w,
                              ),
                              Text(
                                '\$28/month',
                                style: subtitle.copyWith(fontSize: 11.sp),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            'Toronto, Canada',
                            style: gilroy12_600.copyWith(color: cardSubtitle),
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.58,
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
                              style: gilroy12_400.copyWith(
                                color: aboutGrey,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
