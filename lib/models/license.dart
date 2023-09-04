import 'package:flutter_project_labour_app/models/license_model.dart';

class License {
  License({
    required this.id,
    required this.labourId,
    required this.licenseName,
    required this.description,
    required this.from,
    required this.to,
    required this.expiryDate,
    required this.createdAt,
    required this.updatedAt,
  });
  late int? id;
  late int? labourId;
  late String licenseName;
  late String description;
  late String from;
  late String to;
  late String expiryDate;
  late String? createdAt;
  late String? updatedAt;

  License.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    labourId = json['labour_id'];
    licenseName = json['license_name'];
    description = json['description'];
    from = json['from'];
    to = json['to'];
    expiryDate = json['expiry_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['labour_id'] = labourId;
    data['license_name'] = licenseName;
    data['description'] = description;
    data['from'] = from;
    data['to'] = to;
    data['expiry_date'] = expiryDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  LicenseModel toModel() {
    return LicenseModel(
      licenseName: licenseName,
      description: description,
      from: from,
      to: to,
      expiryDate: expiryDate,
    );
  }
}
