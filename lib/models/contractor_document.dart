class Document {
  Document({
    required this.id,
    required this.contractorId,
    required this.ownerDrivingLicense,
    required this.insuranceLiability,
    required this.wcbDocument,
    required this.businessLicense,
    required this.documentUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int contractorId;
  late final String ownerDrivingLicense;
  late final String insuranceLiability;
  late final String wcbDocument;
  late final String businessLicense;
  late final String documentUrl;
  late final String createdAt;
  late final String updatedAt;
  
  Document.fromJson(Map<String, dynamic> json){
    id = json['id'];
    contractorId = json['contractor_id'];
    ownerDrivingLicense = json['owner_driving_license'];
    insuranceLiability = json['insurance_liability'];
    wcbDocument = json['wcb_document'];
    businessLicense = json['business_license'];
    documentUrl = json['document_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['contractor_id'] = contractorId;
    data['owner_driving_license'] = ownerDrivingLicense;
    data['insurance_liability'] = insuranceLiability;
    data['wcb_document'] = wcbDocument;
    data['business_license'] = businessLicense;
    data['document_url'] = documentUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}