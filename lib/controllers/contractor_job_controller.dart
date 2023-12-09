import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/bidder.dart';
import 'package:flutter_project_labour_app/models/bided_job.dart';
import 'package:flutter_project_labour_app/models/job.dart';
import 'package:flutter_project_labour_app/models/job_model.dart';
import 'package:flutter_project_labour_app/models/labour_profile.dart';
import 'package:flutter_project_labour_app/models/pagination_model.dart';
import 'package:flutter_project_labour_app/util/endpoints.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_project_labour_app/util/storage_access.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ContractorJobController extends GetxController {
  var duration = Rx<String?>(null);
  var skills = <String>[].obs;
  var filterSkills = <String>[].obs;
  var filterLocations = <String>[].obs;
  var myJobs = <Job>[].obs;
  var allJobs = <Job>[].obs;
  var allJobsFiltered = <Job>[].obs;
  var allHired = <int, List<LabourProfile>>{}.obs;
  var currentApplicants = <LabourProfile>[].obs;
  var currentBidders = <Bidder>[].obs;
  var recentHires = <LabourProfile>[].obs;
  var allBids = <BidedJob>[].obs;
  String searchString = '';
  Rx<PaginationModel?> paginationData = Rx<PaginationModel?>(null);
  ScrollController scrollController = ScrollController();
  var isFetchingJob = false.obs;
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
  var isApplicantsLoading = false.obs;
  var isHiring = false.obs;
  var isApplying = false.obs;
  var isJobLoading = false.obs;
  var jobNameMessage = 'Enter a Job Name';
  var jobTypeMessage = 'Enter a Job Type';
  var salaryRangeMessage = 'Enter a Salary Range';
  var locationMessage = 'Enter a location';
  var durationMessage = 'Enter Job Duration';
  var descriptionMessage = 'Enter a Description';

  void searchJobs(String value) {
    allJobsFiltered.clear();
    allJobsFiltered.addAll(
      allJobs.where(
        (Job job) =>
            job.name.toLowerCase().contains(value) ||
            job.type.toLowerCase().contains(value),
      ),
    );
  }

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
      showErrorSnackBar('Enter atleast one Qualifications');
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

  bool addFilterSkill(String skill) {
    if (!filterSkills.contains(skill)) {
      filterSkills.add(skill);
      notifyChildrens();
      return true;
    }
    return false;
  }

  void removeSkill(String skill) {
    skills.remove(skill);
    notifyChildrens();
  }

  void removeFilterSkill(String skill) {
    filterSkills.remove(skill);
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

  void changeIsApplying(bool value) {
    isApplying(value);
    notifyChildrens();
  }

  void changeApplicantsLoading(bool value) {
    isApplicantsLoading(value);
    notifyChildrens();
  }

  void changeIsHiring(bool value) {
    isHiring(value);
    notifyChildrens();
  }

  bool isHired(int jobId, int labourId) {
    if (allHired.containsKey(jobId)) {
      var labours = allHired[jobId]!.where((element) => element.id == labourId);
      if (labours.isNotEmpty) {
        return true;
      }
    }
    return false;
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
    salaryRangeTextController.text = job.salaryRange.toString();
    skills.value = job.skills;
    locationTextController.text = job.enterLocation;
    durationTextController.text = job.duration.split(' ')[0];
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
      myJobs.clear();
      myJobs.addAll(jobs.map((e) => Job.fromJson(e)));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getAllJobs() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.get(
      Uri.parse(
        '${Endpoints.contractorAllJobs}?limit=10&page=1&get_expired_job=false',
      ),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      if (body['data']['jobs'] != null) {
        var jobs = body['data']['jobs'] as List;
        allJobs.clear();
        allJobs.addAll(jobs.map((e) => Job.fromJson(e)));
        allJobsFiltered.clear();
        allJobsFiltered.addAll(allJobs);
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
      'get_expired_job': false
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
      Uri.https(Endpoints.domain, '/v1/contractor/jobs', params),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      var jobs = body['data']['jobs'] as List;
      allJobs.addAll(jobs.map((e) => Job.fromJson(e)));
      allJobsFiltered.addAll(jobs.map((e) => Job.fromJson(e)));
      paginationData(PaginationModel.fromJson(body['data']['pagination']));
      print(
          'Page number: ${paginationData.value!.page} || max page: ${paginationData.value!.totalPage}');
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
      'get_expired_job': false,
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
    debugPrint(
        Uri.https(Endpoints.domain, '/v1/contractor/jobs', params).toString());
    var response = await http.get(
      Uri.https(Endpoints.domain, '/v1/contractor/jobs', params),
      headers: {'Authorization': 'Bearer $token'},
    );
    debugPrint(response.body);
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      var jobs = body['data']['jobs'] as List;
      allJobsFiltered.clear();
      allJobsFiltered.addAll(jobs.map((e) => Job.fromJson(e)));
      paginationData(PaginationModel.fromJson(body['data']['pagination']));
      isJobLoading(false);
      return true;
    } else {
      isJobLoading(false);
      showErrorSnackBar("Some problem occurred");
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

  Future<bool> getJobApplicants(int id) async {
    changeApplicantsLoading(true);
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.get(
      Uri.parse('${Endpoints.contractorJobApplicants}?id=$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      if (body['data']['labour'] != null) {
        var applicants = body['data']['labour'] as List;
        currentApplicants.clear();
        currentApplicants.addAll(
          applicants.map((e) => LabourProfile.fromJson(e)),
        );
      } else {
        currentApplicants.clear();
      }
      if (body['data']['contractor'] != null) {
        var applicants = body['data']['contractor'] as List;
        currentBidders.clear();
        currentBidders.addAll(
          applicants.map((e) => Bidder.fromJson(e)),
        );
      } else {
        currentBidders.clear();
      }
      changeApplicantsLoading(false);
      return true;
    } else {
      changeApplicantsLoading(false);
      return false;
    }
  }

  Future<bool> hire(int jobId, int labourId) async {
    changeIsHiring(true);
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.post(
      Uri.parse('${Endpoints.contractorhired}?labour_id=$labourId&id=$jobId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    changeIsHiring(false);
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    if (response.statusCode < 299) {
      await getAllHired();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hireContractor(int jobId, int contractorId) async {
    changeIsHiring(true);
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.post(
      Uri.parse(
          '${Endpoints.contractorhired}?contractor_id=$contractorId&id=$jobId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    changeIsHiring(false);
    debugPrint(Uri.parse(
      '${Endpoints.contractorhired}?contractor_id=$contractorId&id=$jobId',
    ).toString());
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    if (response.statusCode < 299) {
      await getAllHired();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getAllHired() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.get(
      Uri.parse(Endpoints.contractorhired),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      if (body['data'] != null) {
        var datas = body['data'] as List;
        allHired.clear();
        for (var data in datas) {
          try {
            var job = Job.fromJson(data['job']);
            var hires = LabourProfile.fromJson(data['labour']);
            if (allHired.containsKey(job.id)) {
              allHired[job.id]!.add(hires);
            } else {
              allHired[job.id] = [hires];
            }
          } catch (e) {
            debugPrint(e.toString());
          }
        }
      }
      notifyChildrens();
      // for (var items in allHired.entries) {
      //   debugPrint('${items.key}: ${items.value.map((e) => e.id).toList()}');
      // }
      debugPrint('all hired: ${allHired.string}');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getAllBids() async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.get(
      Uri.parse(Endpoints.contractorBidding),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      if (body['data']['job'] != null) {
        var jobs = body['data']['job'] as List;
        allBids.addAll(jobs.map((e) => BidedJob.fromJson(e)));
        allBids.forEach((element) => print(element.id));
      }
      print('response: ${allBids.length}');
      return true;
    } else {
      print("Error getting data");
      return false;
    }
  }

  num? hasBid(int id) {
    var bid = allBids.where((bid) => bid.id == id);
    if (bid.isEmpty) {
      return null;
    }
    return bid.first.biddingAmount;
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

  Future<bool> bid(int id, num amount) async {
    var token = await StorageAccess.getToken();
    if (token == null) {
      return false;
    }
    var response = await http.post(
      Uri.parse('${Endpoints.contractorBidding}?bid=$amount&id=$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode < 299) {
      await getAllBids();
      return true;
    } else {
      return false;
    }
  }
}
