import 'package:get/get.dart';

class FileUploadController extends GetxController {
  var isUploading = false.obs;
  void changeIsUploading(bool value) {
    isUploading(value);
  }
}
