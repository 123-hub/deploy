class JobModel {
  JobModel({
    required this.name,
    required this.type,
    required this.salaryRange,
    required this.skills,
    required this.enterLocation,
    required this.duration,
    required this.description,
  });
  late final String name;
  late final String type;
  late final int salaryRange;
  late final List<String> skills;
  late final String enterLocation;
  late final String duration;
  late final String description;
  
  JobModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    type = json['type'];
    salaryRange = json['salary_range'];
    skills = List.castFrom<dynamic, String>(json['skills']);
    enterLocation = json['enter_location'];
    duration = json['duration'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['type'] = type;
    _data['salary_range'] = salaryRange;
    _data['skills'] = skills;
    _data['enter_location'] = enterLocation;
    _data['duration'] = duration;
    _data['description'] = description;
    return _data;
  }
}