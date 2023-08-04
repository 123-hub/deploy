import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/app_state_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/client_chat_screen.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/client_profile_screen.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/user_search_secreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientDashboardScreen extends StatelessWidget {
  ClientDashboardScreen({super.key});
  final List<Widget> screens = [
    Center(
      child: Text(
        'HOME',
        style: TextStyle(fontSize: 50),
      ),
    ),
    UserSearchScreen(),
    Center(
      child: Text(
        'CreateJob',
        style: TextStyle(fontSize: 50),
      ),
    ),
    ClientChatScreen(),
    const ClientProfileScreen(),
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
                height: 25.h,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Search',
              icon: Image.asset(
                'assets/images/search_icon.png',
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
