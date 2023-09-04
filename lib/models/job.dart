class Job {
  Job({
    required this.id,
    required this.contractorId,
    required this.name,
    required this.type,
    required this.salaryRange,
    required this.skills,
    required this.enterLocation,
    required this.duration,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late int id;
  late int contractorId;
  late String name;
  late String type;
  late int salaryRange;
  late List<String> skills;
  late String enterLocation;
  late String duration;
  late String description;
  late String status;
  late String createdAt;
  late String updatedAt;

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contractorId = json['contractor_id'];
    name = json['name'];
    type = json['type'];
    salaryRange = json['salary_range'];
    skills = List.castFrom<dynamic, String>(json['skills']);
    enterLocation = json['enter_location'];
    duration = json['duration'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['contractor_id'] = contractorId;
    data['name'] = name;
    data['type'] = type;
    data['salary_range'] = salaryRange;
    data['skills'] = skills;
    data['enter_location'] = enterLocation;
    data['duration'] = duration;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
