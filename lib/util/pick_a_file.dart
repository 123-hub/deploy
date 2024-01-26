import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<Map<String, dynamic>?> pickAFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    return {
      'name': result.files.single.name,
      'file': File(result.files.single.path!),
    };
  } else {
    return null;
  }
}
