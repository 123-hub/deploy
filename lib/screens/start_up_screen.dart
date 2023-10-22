import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/apply_job_controller.dart';
import 'package:flutter_project_labour_app/controllers/contractor_chat_controller.dart';
import 'package:flutter_project_labour_app/controllers/contractor_dashboard_controller.dart';
import 'package:flutter_project_labour_app/controllers/contractor_job_controller.dart';
import 'package:flutter_project_labour_app/controllers/contractor_profile_controller.dart';
import 'package:flutter_project_labour_app/controllers/labour_chat_controller.dart';
import 'package:flutter_project_labour_app/controllers/labour_dashboard_controller.dart';
import 'package:flutter_project_labour_app/controllers/labour_profile_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/client_dashboard_screen.dart';
import 'package:flutter_project_labour_app/screens/login_screens/login_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/dashboard_screen.dart';
import 'package:flutter_project_labour_app/util/storage_access.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class StartUpScreen extends StatelessWidget {
  const StartUpScreen({super.key});

  void onStartup() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      Get.off(() => LoginScreen());
      return;
    }
    var role = await StorageAccess.getRole();
    if (role == 'labour') {
      var labourProfileController = Get.put(
        LabourProfileController(),
        permanent: true,
      );
      var success = await labourProfileController.getProfile();
      if (success) {
        var applyJobController = Get.put(
          ApplyJobController(),
          permanent: true,
        );
        var dashboardController = Get.put(
          LabourDashboardController(),
          permanent: true,
        );
        var labourChartController = Get.put(
          LabourChatController(),
          permanent: true,
        );

        await applyJobController.getAllJobs();
        await applyJobController.getAppliedJobs();
        await applyJobController.getSavedJobs();
        await labourChartController.getRooms();
        Get.off(() => DashboardScreen());
      } else {
        Get.off(() => LoginScreen());
      }
    } else {
      var contractProfileController = Get.put(
        ContractorProfileController(),
        permanent: true,
      );
      var success = await contractProfileController.getProfile();
      if (success) {
        var dashboardController = Get.put(
          ContractorDashboardController(),
          permanent: true,
        );
        var contractorJobController = Get.put(
          ContractorJobController(),
          permanent: true,
        );
        var contractorChatController = Get.put(
          ContractorChatController(),
          permanent: true,
        );
        await contractorJobController.getJobs();
        contractorJobController.getAllJobs();
        contractorJobController.getAllHired();
        await contractorJobController.getAllBids();
        contractorChatController.getRooms();
        Get.off(() => ClientDashboardScreen());
      } else {
        Get.off(() => LoginScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    onStartup();
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animations/loading.json',
          repeat: true,
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
