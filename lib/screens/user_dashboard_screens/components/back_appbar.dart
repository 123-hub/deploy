import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/app_state_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BackAppBar extends StatelessWidget {
  BackAppBar({
    super.key,
  });
  final appStateController = Get.put(AppStateController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            appStateController.changeDashboardScreen(0);
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
