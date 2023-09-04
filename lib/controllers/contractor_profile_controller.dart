import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/contractor_document.dart';
import 'package:flutter_project_labour_app/models/contractor_profile.dart';
import 'package:flutter_project_labour_app/util/endpoints.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_project_labour_app/util/storage_access.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContractorProfileController extends GetxController {
  var contractorProfile = Rx<ContractorProfile?>(null);
  var isUpdating = false.obs;
  var documents = <ContractorDocument>[].obs;

  bool addDocument(ContractorDocument document) {
    if (!documents.contains(document)) {
      documents.add(document);
      notifyChildrens();
      return true;
    }
    showErrorSnackBar('Document already exists');
    return false;
  }

  void deleteDocument(ContractorDocument document) {
    documents.remove(document);
    notifyChildrens();
  }

  void changeIsUpdating(bool value) {
    isUpdating(value);
    notifyChildrens();
  }

  Future<bool> getProfile() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.get(
      Uri.parse(Endpoints.contractorProfile),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode < 299) {
      _onUpdate(response.body);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfile() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.patch(
      Uri.parse(Endpoints.contractorProfile),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(contractorProfile.value!.toJson()),
    );
    if (response.statusCode < 299) {
      _onUpdate(response.body);
      return true;
    } else {
      return false;
    }
  }

  void _onUpdate(String response) {
    var body = jsonDecode(response);
    contractorProfile.value = ContractorProfile.fromJson(body['data']);
    documents.clear();
    documents.addAll(contractorProfile.value!.documents);
    debugPrint(contractorProfile.value!.toJson().toString());
    notifyChildrens();
  }
}
