import 'package:get/get.dart';

class AppStateController extends GetxController {
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;
  var sliderValue = 21.obs;
  var gender = Rx<String?>(null);
  var skills = <String>[].obs;

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
}
