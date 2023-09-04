import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/job.dart';
import 'package:flutter_project_labour_app/models/job_model.dart';
import 'package:flutter_project_labour_app/util/endpoints.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_project_labour_app/util/storage_access.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ContractorJobController extends GetxController {
  var duration = Rx<String?>(null);
  var skills = <String>[].obs;
  var allJobs = <Job>[].obs;
  final jobNameTextController = TextEditingController();
  final jobTypeTextController = TextEditingController();
  final salaryRangeTextController = TextEditingController();
  final locationTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final skillTextController = TextEditingController();
  final durationTextController = TextEditingController();
  var isJobNameValid = true.obs;
  var isJobTypeValid = true.obs;
  var isSalaryRangeValid = true.obs;
  var islocationValid = true.obs;
  var isdurationValid = true.obs;
  var isDescriptionValid = true.obs;
  var isLoading = false.obs;
  var jobNameMessage = 'Enter a Job Name';
  var jobTypeMessage = 'Enter a Job Type';
  var salaryRangeMessage = 'Enter a Salary Range';
  var locationMessage = 'Enter a location';
  var durationMessage = 'Enter Job Duration';
  var descriptionMessage = 'Enter a Description';

  bool validateFirstPage() {
    if (jobNameTextController.text.isEmpty) {
      isJobNameValid(false);
    } else {
      isJobNameValid(true);
    }
    if (jobTypeTextController.text.isEmpty) {
      isJobTypeValid(false);
    } else {
      isJobTypeValid(true);
    }
    if (salaryRangeTextController.text.isEmpty) {
      isSalaryRangeValid(false);
    } else {
      isSalaryRangeValid(true);
    }
    if (locationTextController.text.isEmpty) {
      islocationValid(false);
    } else {
      islocationValid(true);
    }
    if (durationTextController.text.isEmpty) {
      isdurationValid(false);
    } else {
      isdurationValid(true);
    }
    if (duration.value == null) {
      showErrorSnackBar("Enter duration type");
    }
    if (isJobNameValid.value &&
        isJobTypeValid.value &&
        isSalaryRangeValid.value &&
        islocationValid.value &&
        isdurationValid.value &&
        duration.value != null) {
      return true;
    }
    return false;
  }

  bool validateSecondPage() {
    if (descriptionTextController.text.isEmpty) {
      isDescriptionValid(false);
    } else {
      isDescriptionValid(true);
    }

    if (skills.isEmpty) {
      showErrorSnackBar('Enter atleast one skill');
    }
    if (isDescriptionValid.value && skills.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool addSkill(String skill) {
    if (!skills.contains(skill)) {
      skills.add(skill);
      notifyChildrens();
      return true;
    }
    return false;
  }

  void removeSkill(String skill) {
    skills.remove(skill);
    notifyChildrens();
  }

  void changeDuration(String? value) {
    duration(value);
    notifyChildrens();
  }

  void changeLoading(bool value) {
    isLoading(value);
    notifyChildrens();
  }

  JobModel getJobData() {
    return JobModel(
      name: jobNameTextController.text,
      type: jobTypeTextController.text,
      salaryRange: int.parse(salaryRangeTextController.text),
      skills: [...skills.map((element) => element.trim())],
      enterLocation: locationTextController.text,
      duration: '${durationTextController.text} ${duration.value}',
      description: descriptionTextController.text,
    );
  }

  void updateJobData(Job job) {
    jobNameTextController.text = job.name;
    jobTypeTextController.text = job.type;
    salaryRangeTextController.text =
        job.salaryRange.toString();
    skills.value = job.skills;
    locationTextController.text = job.enterLocation;
    durationTextController.text =
        job.duration.split(' ')[0];
    descriptionTextController.text = job.description;
    duration.value = job.duration.split(' ')[1];
  }

  Future<bool> createJob() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.post(
      Uri.parse(Endpoints.contractorJob),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(getJobData().toJson()),
    );
    if (response.statusCode < 299) {
      _jobPostedCleanup();
      await getJobs();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getJobs() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.get(
      Uri.parse(Endpoints.contractorJob),
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

  Future<bool> deleteJob(int id) async {
    changeLoading(true);
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.delete(
      Uri.parse('${Endpoints.contractorJob}?id=$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode < 299) {
      await getJobs();
      changeLoading(false);
      return true;
    } else {
      changeLoading(false);
      return false;
    }
  }

  Future<bool> updateJob(int id) async {
    debugPrint(getJobData().toJson().toString());
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.patch(
      Uri.parse('${Endpoints.contractorJob}?id=$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(getJobData().toJson()),
    );
    if (response.statusCode < 299) {
      _jobPostedCleanup();
      await getJobs();
      return true;
    } else {
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return false;
    }
  }

  void _jobPostedCleanup() {
    skills.clear();
    jobNameTextController.clear();
    jobTypeTextController.clear();
    salaryRangeTextController.clear();
    locationTextController.clear();
    durationTextController.clear();
    skillTextController.clear();
    descriptionTextController.clear();
  }
}
