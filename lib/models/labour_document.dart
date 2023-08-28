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
  late final int id;
  late final int labourId;
  late final String documentName;
  late final String documentUrl;
  late final String description;
  late final String createdAt;
  late final String updatedAt;
  
  Document.fromJson(Map<String, dynamic> json){
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
}