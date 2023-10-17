import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_dashboard_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/contractor_conversation_screen.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/client_profile_screen.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/all_jobs_screen.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/contractor_home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientDashboardScreen extends StatelessWidget {
  ClientDashboardScreen({super.key});
  final List<Widget> screens = [
    ContractorHomeScreen(),
    AllJobsScreen(),
    const Center(
      child: Text(
        'CreateJob',
        style: TextStyle(fontSize: 50),
      ),
    ),
    ContractorConversationScreen(),
    ClientProfileScreen(),
  ];
  final dashboardController = Get.find<ContractorDashboardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
            child: screens[dashboardController.dashboardIndex.value]);
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          showSelectedLabels: false,
          currentIndex: dashboardController.dashboardIndex.value,
          onTap: dashboardController.changeDashboardScreen,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Image.asset(
                'assets/images/home_icon.png',
                height: 25.h,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Search',
              icon: Image.asset(
                'assets/images/all_jobs.png',
                height: 25.h,
              ),
            ),
            BottomNavigationBarItem(
              label: 'BookMark',
              icon: Image.asset(
                'assets/images/add_post_icon.png',
                height: 25.h,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Message',
              icon: Image.asset(
                'assets/images/message_icon.png',
                height: 25.h,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Image.asset(
                'assets/images/profile_icon.png',
                height: 25.h,
              ),
            )
          ],
        );
      }),
    );
  }
}
