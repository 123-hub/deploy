import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_dashboard_controller.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientBackAppBarWithLabel extends StatelessWidget {
  ClientBackAppBarWithLabel({
    required this.label,
    this.toHomeScreen = true,
    super.key,
  });

  final String label;
  final dashboardController = Get.find<ContractorDashboardController>();
  final bool toHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Get.back();
                if (toHomeScreen) {
                  dashboardController.changeDashboardScreen(0);
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              label,
              style: gilroy18sp,
            )
          ],
        ),
        Image.asset(
          'assets/images/notification.png',
          height: 25.h,
        ),
      ],
    );
  }
}
