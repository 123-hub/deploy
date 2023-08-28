import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/contractor_profile.dart';
import 'package:flutter_project_labour_app/util/endpoints.dart';
import 'package:flutter_project_labour_app/util/storage_access.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContractorProfileController extends GetxController {
  var contractorProfile = Rx<ContractorProfile?>(null);

  Future<bool> getProfile() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.get(
      Uri.parse(Endpoints.labourProfile),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      contractorProfile.value = ContractorProfile.fromJson(body['data']);
      debugPrint(contractorProfile.value!.toJson().toString());
      return true;
    } else {
      return false;
    }
  }
}
