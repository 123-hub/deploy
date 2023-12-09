import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/experience.dart';
import 'package:flutter_project_labour_app/models/labour_document.dart';
import 'package:flutter_project_labour_app/models/labour_profile.dart';
import 'package:flutter_project_labour_app/models/license.dart';
import 'package:flutter_project_labour_app/util/endpoints.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_project_labour_app/util/storage_access.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LabourProfileController extends GetxController {
  var labourProfile = Rx<LabourProfile?>(null);
  RxList<bool> days = List.filled(7, false).obs;
  RxList<Experience> experiences = <Experience>[].obs;
  RxList<License> licenses = <License>[].obs;
  RxList<Document> documents = <Document>[].obs;
  RxList<String> skills = <String>[].obs;

  var isUpdating = false.obs;
  final weekdays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  void changeIsUpdating(bool value) {
    isUpdating(value);
    notifyChildrens();
  }

  void selectDays(int day) {
    debugPrint('selected day index $day');
    days[day] = !days[day];
    notifyChildrens();
  }

  bool addExperience(Experience experience) {
    if (!experiences.contains(experience)) {
      experiences.add(experience);
      notifyChildrens();
      return true;
    }
    showErrorSnackBar('Experience already exists');
    return false;
  }

  void deleteExperience(Experience experience) {
    experiences.remove(experience);
    notifyChildrens();
  }

  bool addDocument(Document document) {
    if (!documents.contains(document)) {
      documents.add(document);
      notifyChildrens();
      return true;
    }
    showErrorSnackBar('Document already exists');
    return false;
  }

  void deleteDocument(Document document) {
    documents.remove(document);
    notifyChildrens();
  }

  bool addLicense(License license) {
    if (!licenses.contains(license)) {
      licenses.add(license);
      notifyChildrens();
      return true;
    }
    showErrorSnackBar('License already exists');
    return false;
  }

  void deleteLicense(License license) {
    licenses.remove(license);
    notifyChildrens();
  }

  bool addSkill(String skill) {
    if (!skills.contains(skill)) {
      skills.add(skill);
      notifyChildrens();
      return true;
    }
    showErrorSnackBar('Skill already exists');
    return false;
  }

  void deleteSkill(String skill) {
    skills.remove(skill);
    notifyChildrens();
  }

  String getDays() {
    var added = <String>[];
    for (var i = 0; i < 7; i++) {
      if (days[i]) {
        added.add(weekdays[i]);
      }
    }
    var result = '';
    for (var i = 0; i < added.length - 1; i++) {
      result += '${added[i]}, ';
    }
    result += added[added.length - 1];
    return result;
  }

  void setDays() {
    var gotDays = labourProfile.value!.availabilityDates
        .split(',')
        .map((e) => e.trim())
        .toList();
    for (var day in gotDays) {
      var index = weekdays.indexOf(day);
      days[index] = true;
    }
  }

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
      Uri.parse(Endpoints.labourProfile),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(labourProfile.value!.toJson()),
    );
    if (response.statusCode < 299) {
      _onUpdate(response.body);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfileValues(LabourProfile labourProfile) async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    log(jsonEncode(labourProfile.toJson().toString()));
    var response = await http.patch(
      Uri.parse(Endpoints.labourProfile),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(labourProfile.toJson()),
    );
    if (response.statusCode < 299) {
      _onUpdate(response.body);
      return true;
    } else {
      print('${response.statusCode} ${response.body}');
      return false;
    }
  }

    Future<bool> deleteItem(String type, int id) async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    changeIsUpdating(true);
    var response = await http.delete(
      Uri.parse('${Endpoints.deleteLabourProfileDoc}?id=$id&type=$type'),
      headers: {'Authorization': 'Bearer $token'},
    );
    changeIsUpdating(false);
    if (response.statusCode < 299) {
      return true;
    } else {
      return false;
    }
  }

  void _onUpdate(String response) {
    var body = jsonDecode(response);
    labourProfile.value = LabourProfile.fromJson(body['data']);
    setDays();
    experiences.clear();
    experiences.addAll(labourProfile.value!.experience);
    documents.clear();
    documents.addAll(labourProfile.value!.documents);
    licenses.clear();
    licenses.addAll(labourProfile.value!.licenses);
    skills.clear();
    skills.addAll(labourProfile.value!.tradeType);
    debugPrint(labourProfile.value!.toJson().toString());
    notifyChildrens();
  }
}
