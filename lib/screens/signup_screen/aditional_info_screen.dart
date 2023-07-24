import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/app_state_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_appbar.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdditionalInfoScreen extends StatelessWidget {
  AdditionalInfoScreen({super.key});
  final appStateController = Get.put(AppStateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 37.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                const AuthAppBar(),
                SizedBox(
                  height: 71.h,
                ),
                Text(
                  'Additional Info',
                  style: authHeading,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing',
                  style: subtitle.copyWith(color: subtitleGrey),
                ),
                SizedBox(
                  height: 36.h,
                ),
                Text(
                  'Enter your age',
                  style: authInfoHeading,
                ),
                Obx(
                  () {
                    return Slider(
                      min: 0.0,
                      max: 100.0,
                      value: appStateController.sliderValue.value,
                      divisions: 100,
                      label: '${appStateController.sliderValue.value.round()}',
                      onChanged: appStateController.onSliderChanged,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
