import 'package:get/get.dart';

class AppStateController extends GetxController {
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;
  var sliderValue = 0.0.obs;

  void onSliderChanged(double value) {
    sliderValue.value = value;
  }

  void chageShowPassword() {
    showPassword(!showPassword.value);
  }

  void chageConfirmShowPassword() {
    showConfirmPassword(!showConfirmPassword.value);
  }
}
