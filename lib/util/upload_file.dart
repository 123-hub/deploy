import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_project_labour_app/util/endpoints.dart';

Future<String?> uploadFile(
    {required String userType, required File file}) async {
  Uri url = userType == 'labour'
      ? Uri.parse(Endpoints.labourUploadFile)
      : Uri.parse(Endpoints.contractorUploadFile);

  var request = http.MultipartRequest('POST', url);
  // request.headers[''];
  request.files.add(await http.MultipartFile.fromPath('file', file.path));
  try {
    var response = await request.send();
    String responseString = await response.stream.bytesToString();

    if (response.statusCode < 299) {
      var body = jsonDecode(responseString);
      return body['data'];
    } else {
      print('Error is $responseString');
      return null;
    }
  } catch (error) {
    return null;
  }
}
