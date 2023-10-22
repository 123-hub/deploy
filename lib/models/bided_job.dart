class BidedJob {
  BidedJob({
    required this.id,
    required this.contractorId,
    required this.name,
    required this.type,
    required this.salaryRange,
    required this.skills,
    required this.enterLocation,
    required this.duration,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.biddingAmount,
    required this.contractor,
  });
  late int id;
  late int contractorId;
  late String name;
  late String type;
  late int salaryRange;
  late List<String> skills;
  late String enterLocation;
  late String duration;
  late String description;
  late String status;
  late String createdAt;
  late String updatedAt;
  late int biddingAmount;
  late Contractor contractor;

  BidedJob.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contractorId = json['contractor_id'];
    name = json['name'];
    type = json['type'];
    salaryRange = json['salary_range'];
    skills = List.castFrom<dynamic, String>(json['skills']);
    enterLocation = json['enter_location'];
    duration = json['duration'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    biddingAmount = json['bidding_amount'];
    contractor = Contractor.fromJson(json['contractor']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['contractor_id'] = contractorId;
    data['name'] = name;
    data['type'] = type;
    data['salary_range'] = salaryRange;
    data['skills'] = skills;
    data['enter_location'] = enterLocation;
    data['duration'] = duration;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['bidding_amount'] = biddingAmount;
    data['contractor'] = contractor.toJson();
    return data;
  }
}

class Contractor {
  Contractor({
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
  late final List<dynamic> documents;
  late final bool isApproved;
  late final String createdAt;
  late final String updatedAt;

  Contractor.fromJson(Map<String, dynamic> json) {
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
    documents = List.castFrom<dynamic, dynamic>(json['documents']);
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
    data['documents'] = documents;
    data['is_approved'] = isApproved;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
