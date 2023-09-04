import 'package:flutter_project_labour_app/models/document_model.dart';

class Document {
  Document({
    required this.id,
    required this.labourId,
    required this.documentName,
    required this.documentUrl,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });
  late  int? id;
  late  int? labourId;
  late  String documentName;
  late  String documentUrl;
  late  String description;
  late  String? createdAt;
  late  String? updatedAt;

  Document.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    labourId = json['labour_id'];
    documentName = json['document_name'];
    documentUrl = json['document_url'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['labour_id'] = labourId;
    data['document_name'] = documentName;
    data['document_url'] = documentUrl;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  DocumentModel toModel() {
    return DocumentModel(
      documentName: documentName,
      documentUrl: documentUrl,
      description: description,
    );
  }
}
