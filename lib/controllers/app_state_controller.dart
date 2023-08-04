import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_card_without_tag.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AppStateController extends GetxController {
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;
  var sliderValue = 21.obs;
  var gender = Rx<String?>(null);
  var skills = <String>[].obs;
  var dashboardIndex = 0.obs;
  var jobTiels = <JobCardWithoutTag>[].obs;
  var salaryRange = Rx<SfRangeValues>(SfRangeValues(100000, 300000));

  @override
  void onInit() {
    jobTiels.addAll([
      for (int i = 0; i < 20; i++)
        JobCardWithoutTag(
          price: i,
        )
    ]);
    super.onInit();
  }

  void changeSalaryRange(SfRangeValues values) {
    salaryRange(values);
    notifyChildrens();
  }

  void removeSavedJob(int index) {
    jobTiels.removeAt(index);
    notifyChildrens();
  }

  void onSliderChanged(dynamic value) {
    sliderValue.value = value.round();
  }

  void chageShowPassword() {
    showPassword(!showPassword.value);
  }

  void chageConfirmShowPassword() {
    showConfirmPassword(!showConfirmPassword.value);
  }

  void onGenderChange(String? value) {
    gender(value);
  }

  bool addSkill(String skill) {
    if (skill.trim() != '') {
      if (skills.contains(skill)) {
        return false;
      }
      skills.add(skill);
      notifyChildrens();
      return true;
    }
    return false;
  }

  void deleteSkill(String skill) {
    skills.remove(skill);
    notifyChildrens();
  }

  void changeDashboardScreen(int index) {
    dashboardIndex(index);
  }
}
