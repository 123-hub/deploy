class DocumentModel {
  DocumentModel({
    required this.documentName,
    required this.documentUrl,
    required this.description,
  });
  late final String documentName;
  late final String documentUrl;
  late final String description;
  
  DocumentModel.fromJson(Map<String, dynamic> json){
    documentName = json['document_name'];
    documentUrl = json['document_url'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['document_name'] = documentName;
    data['document_url'] = documentUrl;
    data['description'] = description;
    return data;
  }
}