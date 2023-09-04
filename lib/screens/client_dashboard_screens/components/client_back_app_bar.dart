import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_dashboard_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContractorBackAppBar extends StatelessWidget {
  ContractorBackAppBar({
    super.key,
  });
  final dashboardController = Get.find<ContractorDashboardController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            dashboardController.changeDashboardScreen(0);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        Image.asset(
          'assets/images/notification.png',
          height: 25.h,
        ),
      ],
    );
  }
}
