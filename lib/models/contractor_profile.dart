import 'package:flutter_project_labour_app/models/contractor_document.dart';

class ContractorProfile {
  ContractorProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.companyName,
    required this.companyAddress,
    required this.companyPhoneNumber,
    required this.companyWebsite,
    required this.companyFaxNumber,
    required this.businessLicenseNumber,
    required this.wcbNumber,
    required this.documents,
    required this.isApproved,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String phoneNumber;
  late final String dateOfBirth;
  late final String companyName;
  late final String companyAddress;
  late final String companyPhoneNumber;
  late final String companyWebsite;
  late final String companyFaxNumber;
  late final String businessLicenseNumber;
  late final String wcbNumber;
  late final List<Document> documents;
  late final bool isApproved;
  late final String createdAt;
  late final String updatedAt;
  
  ContractorProfile.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    companyPhoneNumber = json['company_phone_number'];
    companyWebsite = json['company_website'];
    companyFaxNumber = json['company_fax_number'];
    businessLicenseNumber = json['business_license_number'];
    wcbNumber = json['wcb_number'];
    documents = List.from(json['documents']).map((e)=>Document.fromJson(e)).toList();
    isApproved = json['is_approved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['company_name'] = companyName;
    data['company_address'] = companyAddress;
    data['company_phone_number'] = companyPhoneNumber;
    data['company_website'] = companyWebsite;
    data['company_fax_number'] = companyFaxNumber;
    data['business_license_number'] = businessLicenseNumber;
    data['wcb_number'] = wcbNumber;
    data['documents'] = documents.map((e)=>e.toJson()).toList();
    data['is_approved'] = isApproved;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

