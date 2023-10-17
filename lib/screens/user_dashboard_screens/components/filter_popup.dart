import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/app_state_controller.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

Future<dynamic> filterPopUp(
    BuildContext context, AppStateController appStateController) {
  var skillTextController = TextEditingController();
  return showModalBottomSheet(
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    context: context,
    builder: (context) => SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filters',
                style: bottomSheetTitle,
              ),
              SizedBox(
                height: 32.h,
              ),
              Text(
                'Enter Qualifications',
                style: bottomSheetSubTitle,
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  textInputAction: TextInputAction.go,
                  controller: skillTextController,
                  onSubmitted: (String? value) {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: searchBarColor,
                    hintText: 'Type To Search for job category...',
                    contentPadding: EdgeInsets.only(bottom: 5.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11.r),
                      borderSide: BorderSide.none, // No border
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
              SizedBox(
                height: 32.h,
              ),
              Text(
                'Enter locations',
                style: bottomSheetSubTitle,
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  textInputAction: TextInputAction.go,
                  controller: skillTextController,
                  onSubmitted: (String? value) {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: searchBarColor,
                    hintText: 'Type To Search for location',
                    contentPadding: EdgeInsets.only(bottom: 5.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11.r),
                      borderSide: BorderSide.none, // No border
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
              SizedBox(
                height: 24.h,
              ),
              LongButton(
                text: 'Apply filters',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 32.h,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
