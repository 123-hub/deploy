import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/app_state_controller.dart';
import 'package:flutter_project_labour_app/screens/dashboard_screen/components/home_screen_appbar.dart';
import 'package:flutter_project_labour_app/screens/dashboard_screen/components/job_card.dart';
import 'package:flutter_project_labour_app/screens/dashboard_screen/components/job_search_bar.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
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
                    onTap: () {
                      var skillTextController = TextEditingController();
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          padding: EdgeInsets.symmetric(vertical: 34.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                ),
                                child: Text(
                                  'Filters',
                                  style: bottomSheetTitle,
                                ),
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                ),
                                child: Text(
                                  'Enter salary range',
                                  style: bottomSheetSubTitle,
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Obx(
                                () {
                                  return SfRangeSliderTheme(
                                    data: SfRangeSliderThemeData(
                                      thumbColor: primeryRed,
                                      activeTrackColor: primeryRed,
                                      inactiveTrackColor: inactiveTrackColor,
                                    ),
                                    child: SfRangeSlider(
                                      min: 90000,
                                      max: 500000,
                                      values:
                                          appStateController.salaryRange.value,
                                      enableTooltip: true,
                                      minorTicksPerInterval: 1,
                                      onChanged:
                                          appStateController.changeSalaryRange,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() {
                                      return Center(
                                        child: Text(
                                          '₹ ${appStateController.salaryRange.value.start.round()} - ₹ ${appStateController.salaryRange.value.end.round()}',
                                          style: bottomSheetSubTitle,
                                        ),
                                      );
                                    }),
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                    Text(
                                      'Enter Skills',
                                      style: bottomSheetSubTitle,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      child: TextField(
                                        textInputAction: TextInputAction.go,
                                        controller: skillTextController,
                                        onSubmitted: (String? value) {
                                          
                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: searchBarColor,
                                          contentPadding:
                                              EdgeInsets.only(bottom: 5.h),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(11.r),
                                            borderSide:
                                                BorderSide.none, // No border
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.search,
                                            color: searchBarIconColor,
                                          ),
                                          suffixIcon: const Icon(
                                            Icons.mic,
                                            color: searchBarIconColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
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
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return const JobCard();
              },
            )
          ],
        ),
      ),
    );
  }
}
