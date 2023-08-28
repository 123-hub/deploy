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
  late final int id;
  late final int labourId;
  late final String position;
  late final String companyName;
  late final String description;
  late final String from;
  late final String to;
  late final String createdAt;
  late final String updatedAt;
  
  Experience.fromJson(Map<String, dynamic> json){
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
}
