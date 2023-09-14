import 'package:flutter_project_labour_app/screens/client_dashboard_screens/create_job_screen.dart';
import 'package:get/get.dart';

class ContractorDashboardController extends GetxController {
  var dashboardIndex = 0.obs;

  void changeDashboardScreen(int index) {
    if (index == 1) {
      Get.to(() => CreateJobScreen());
      return;
    }
    dashboardIndex(index);
  }
}
