import 'package:flutter_project_labour_app/models/experience_model.dart';

class Experience {
  Experience({
    required this.id,
    required this.labourId,
    required this.position,
    required this.companyName,
    required this.description,
    required this.from,
    required this.to,
    required this.createdAt,
    required this.updatedAt,
  });
  late int id;
  late int labourId;
  late String position;
  late String companyName;
  late String description;
  late String from;
  late String to;
  late String? createdAt;
  late String? updatedAt;

  Experience.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    labourId = json['labour_id'];
    position = json['position'];
    companyName = json['company_name'];
    description = json['description'];
    from = json['from'];
    to = json['to'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['labour_id'] = labourId;
    data['position'] = position;
    data['company_name'] = companyName;
    data['description'] = description;
    data['from'] = from;
    data['to'] = to;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  ExperienceModel toModel() {
    return ExperienceModel(
      position: position,
      companyName: companyName,
      description: description,
      from: from,
      to: to,
    );
  }
}
