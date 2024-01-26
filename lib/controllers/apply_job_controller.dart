import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/job.dart';
import 'package:flutter_project_labour_app/models/pagination_model.dart';
import 'package:flutter_project_labour_app/util/endpoints.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_project_labour_app/util/storage_access.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApplyJobController extends GetxController {
  RxList<Job> allJobs = <Job>[].obs;
  RxList<Job> appliedJobs = <Job>[].obs;
  RxList<Job> savedJobs = <Job>[].obs;
  RxList<Job> searchedJobs = <Job>[].obs;
  var filterSkills = <String>[].obs;
  var filterLocations = <String>[].obs;
  String searchString = '';
  Rx<PaginationModel?> paginationData = Rx<PaginationModel?>(null);
  ScrollController scrollController = ScrollController();
  var isApplying = false.obs;
  var isSaved = false.obs;
  var isSavedLoading = false.obs;
  var isJobLoading = false.obs;
  var isFetchingJob = false.obs;
  var applyJobSearchController = TextEditingController();
  var appliedJobSearchResult = <Job>[].obs;

  void searchAppliedJobs(String text) {
    appliedJobSearchResult.clear();
    if (text.trim().isEmpty) {
      appliedJobSearchResult.addAll(appliedJobs);
      return;
    }
    var searchString = text.toLowerCase();
    var result = appliedJobs.where((element) =>
        element.name.toLowerCase().contains(searchString) ||
        element.description.toLowerCase().contains(searchString) ||
        element.enterLocation.toLowerCase().contains(searchString));
    if (result.isNotEmpty) {
      appliedJobSearchResult.addAll(result);
    }
  }

  Future<bool> getAllJobs() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.get(
      Uri.parse('${Endpoints.labourJob}?limit=10&page=1&get_expired_job=false'),
      headers: {'Authorization': 'Bearer $token'},
    );
    debugPrint("Get all jobs called");
    print(response.statusCode);
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      if (body['data']['jobs'] != null) {
        var jobs = body['data']['jobs'] as List;
        allJobs.clear();
        allJobs.addAll(jobs.map((e) => Job.fromJson(e)));
        paginationData(PaginationModel.fromJson(body['data']['pagination']));
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getAllJobsNextPage() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    if (paginationData.value!.page >= paginationData.value!.totalPage) {
      return false;
    }
    Map<String, dynamic> params = {
      'limit': '10',
      'page': (paginationData.value!.page + 1).toString(),
      'get_expired_job': 'false',
    };
    if (searchString.isNotEmpty) {
      params['query'] = '%$searchString%';
    }
    if (filterLocations.isNotEmpty) {
      params['locations'] = params['locations'] =
          filterLocations.map((element) => '%$element%').join(",");
    }
    if (filterSkills.isNotEmpty) {
      params['skills'] = filterSkills.join(',');
    }
    var response = await http.get(
      Uri.https(Endpoints.domain, '/v1/labour/jobs', params),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      var jobs = body['data']['jobs'] as List;
      allJobs.addAll(jobs.map((e) => Job.fromJson(e)));
      paginationData(PaginationModel.fromJson(body['data']['pagination']));
      print(
        'Page number: ${paginationData.value!.page} || max page: ${paginationData.value!.totalPage}',
      );
      return true;
    } else {
      showErrorSnackBar("Something went wrong");
      return false;
    }
  }

  Future<bool> applyFilter() async {
    isJobLoading(true);
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    Map<String, dynamic> params = {
      'limit': '10',
      'page': '1',
      'get_expired_job': 'false',
    };
    if (searchString.isNotEmpty) {
      params['query'] = '%$searchString%';
    }
    if (filterLocations.isNotEmpty) {
      params['locations'] =
          filterLocations.map((element) => '%$element%').join(",");
    }
    if (filterSkills.isNotEmpty) {
      params['skills'] = filterSkills.join(',');
    }

    var response = await http.get(
      Uri.https(Endpoints.domain, '/v1/labour/jobs', params),
      headers: {'Authorization': 'Bearer $token'},
    );
    debugPrint(response.body);
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      var jobs = body['data']['jobs'] as List;
      allJobs.clear();
      allJobs.addAll(jobs.map((e) => Job.fromJson(e)));
      paginationData(PaginationModel.fromJson(body['data']['pagination']));
      isJobLoading(false);
      return true;
    } else {
      isJobLoading(false);
      showErrorSnackBar("Some problem occurred");
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
      if (body['data'] != null) {
        var jobs = body['data'] as List;
        appliedJobs.clear();
        appliedJobs.addAll(jobs.reversed.map((e) => Job.fromJson(e)));
      }
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
      if (body['data'] != null) {
        var jobs = body['data'] as List;
        savedJobs.clear();
        savedJobs.addAll(jobs.map((e) => Job.fromJson(e)));
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> saveJob(int id) async {
    isSavedLoading(true);
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
      isSavedLoading(false);
      return true;
    } else {
      isSavedLoading(false);
      return false;
    }
  }

  Future<bool> deleteSavedJob(int id) async {
    isSavedLoading(true);
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
      isSavedLoading(false);
      return true;
    } else {
      isSavedLoading(false);
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
