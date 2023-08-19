class ContractorDocumentModel {
  ContractorDocumentModel({
    required this.ownerDrivingLicense,
    required this.insuranceLiability,
    required this.wcbDocument,
    required this.businessLicense,
    required this.documentUrl,
  });
  late final String ownerDrivingLicense;
  late final String insuranceLiability;
  late final String wcbDocument;
  late final String businessLicense;
  late final String documentUrl;
  
  ContractorDocumentModel.fromJson(Map<String, dynamic> json){
    ownerDrivingLicense = json['owner_driving_license'];
    insuranceLiability = json['insurance_liability'];
    wcbDocument = json['wcb_document'];
    businessLicense = json['business_license'];
    documentUrl = json['document_url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['owner_driving_license'] = ownerDrivingLicense;
    data['insurance_liability'] = insuranceLiability;
    data['wcb_document'] = wcbDocument;
    data['business_license'] = businessLicense;
    data['document_url'] = documentUrl;
    return data;
  }
}