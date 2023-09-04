import 'dart:convert';

import 'package:flutter_project_labour_app/models/job.dart';
import 'package:flutter_project_labour_app/util/endpoints.dart';
import 'package:flutter_project_labour_app/util/storage_access.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApplyJobController extends GetxController {
  RxList<Job> allJobs = <Job>[].obs;
  RxList<Job> appliedJobs = <Job>[].obs;
  RxList<Job> savedJobs = <Job>[].obs;
  RxList<Job> searchedJobs = <Job>[].obs;
  var isApplying = false.obs;
  var isSaved = false.obs;

  Future<bool> getAllJobs() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.get(
      Uri.parse(Endpoints.labourJob),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      var jobs = body['data'] as List;
      allJobs.clear();
      allJobs.addAll(jobs.map((e) => Job.fromJson(e)));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> applyJob(int id) async {
    isApplying(true);
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.post(
      Uri.parse('${Endpoints.labourApplyJobs}?id=$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    isApplying(false);
    if (response.statusCode < 299) {
      await getAppliedJobs();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteApplication(int id) async {
    isApplying(true);
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.delete(
      Uri.parse('${Endpoints.labourApplyJobs}?id=$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    isApplying(false);
    if (response.statusCode < 299) {
      await getAppliedJobs();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getAppliedJobs() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.get(
      Uri.parse(Endpoints.labourApplyJobs),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      var jobs = body['data'] as List;
      appliedJobs.clear();
      appliedJobs.addAll(jobs.map((e) => Job.fromJson(e)));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getSavedJobs() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.get(
      Uri.parse(Endpoints.labourSaveJob),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      var jobs = body['data'] as List;
      savedJobs.clear();
      savedJobs.addAll(jobs.map((e) => Job.fromJson(e)));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> saveJob(int id) async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.post(
      Uri.parse('${Endpoints.labourSaveJob}?id=$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode < 299) {
      isPresentInSavedJobs(id);
      await getSavedJobs();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteSavedJob(int id) async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.delete(
      Uri.parse('${Endpoints.labourSaveJob}?id=$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode < 299) {
      isPresentInSavedJobs(id);
      await getSavedJobs();
      return true;
    } else {
      return false;
    }
  }

  bool isPresentInAppliedJobs(int id) {
    var results = appliedJobs.where((Job job) => job.id == id);
    if (results.isEmpty) {
      return false;
    }
    return true;
  }

  bool isPresentInSavedJobs(int id) {
    var results = savedJobs.where((Job job) => job.id == id);
    if (results.isEmpty) {
      isSaved(false);
      notifyChildrens();
      return false;
    }
    isSaved(true);
    notifyChildrens();
    return true;
  }

  void searchJob(String text) {
    var result = allJobs
        .where((Job job) =>
            job.name.toLowerCase().contains(text.toLowerCase()) ||
            job.description.toLowerCase().contains(text.toLowerCase()))
        .toList();
    searchedJobs.clear();
    searchedJobs.addAll(result);
    notifyChildrens();
  }
}
