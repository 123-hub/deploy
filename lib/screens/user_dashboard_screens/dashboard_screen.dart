import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/app_state_controller.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/conversation_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/home_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/job_bookmark_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final List<Widget> screens = [
    HomeScreen(),
    Center(
      child: Text(
        'SEARCH',
        style: TextStyle(fontSize: 50),
      ),
    ),
    JobBookmarkScreen(),
    ConversationScreen(),
    const ProfileScreen(),
  ];
  final appStateController = Get.put(AppStateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
            child: screens[appStateController.dashboardIndex.value]);
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          showSelectedLabels: false,
          currentIndex: appStateController.dashboardIndex.value,
          onTap: appStateController.changeDashboardScreen,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Image.asset(
                'assets/images/home_icon.png',
                height: 20.h,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Search',
              icon: Image.asset(
                'assets/images/search_icon.png',
                height: 20.h,
              ),
            ),
            BottomNavigationBarItem(
              label: 'BookMark',
              icon: Image.asset(
                'assets/images/bookmark_icon.png',
                height: 20.h,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Message',
              icon: Image.asset(
                'assets/images/message_icon.png',
                height: 20.h,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Image.asset(
                'assets/images/profile_icon.png',
                height: 20.h,
              ),
            )
          ],
        );
      }),
    );
  }
}
