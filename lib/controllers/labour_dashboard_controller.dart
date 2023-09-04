import 'package:get/get.dart';

class LabourDashboardController extends GetxController {
  var dashboardIndex = 0.obs;

  void changeDashboardScreen(int index) {
    dashboardIndex(index);
  }
}