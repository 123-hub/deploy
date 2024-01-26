import 'package:flutter_project_labour_app/controllers/apply_job_controller.dart';
import 'package:get/get.dart';

class LabourDashboardController extends GetxController {
  var jobController = Get.find<ApplyJobController>();
  var dashboardIndex = 0.obs;
  void changeDashboardScreen(int index) {
    dashboardIndex(index);
    jobController.applyJobSearchController.clear();
    jobController.searchAppliedJobs('');
  }
}
