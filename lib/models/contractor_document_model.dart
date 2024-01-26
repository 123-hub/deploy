class ContractorDocumentModel {
  ContractorDocumentModel({
    this.ownerDrivingLicense,
    this.insuranceLiability,
    this.wcbDocument,
    this.businessLicense,
    this.documentUrl,
  });
  String? ownerDrivingLicense;
  String? insuranceLiability;
  String? wcbDocument;
  String? businessLicense;
  String? documentUrl;

  ContractorDocumentModel.fromJson(Map<String, dynamic> json) {
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
