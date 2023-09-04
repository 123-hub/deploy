import 'package:flutter_project_labour_app/models/experience.dart';
import 'package:flutter_project_labour_app/models/labour_document.dart';
import 'package:flutter_project_labour_app/models/license.dart';

class LabourProfile {
  LabourProfile({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.dob,
    required this.expectedHourRate,
    required this.tradeType,
    required this.availabilityDates,
    required this.experience,
    required this.licenses,
    required this.isDriving,
    required this.licenseExpiryDate,
    required this.documents,
    required this.isApproved,
    required this.createdAt,
    required this.updatedAt,
  });
  late int id;
  late String email;
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String dob;
  late int expectedHourRate;
  late List<String> tradeType;
  late String availabilityDates;
  late List<Experience> experience;
  late List<License> licenses;
  late bool isDriving;
  late String licenseExpiryDate;
  late List<Document> documents;
  late bool isApproved;
  late String createdAt;
  late String updatedAt;

  LabourProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    dob = json['dob'];
    expectedHourRate = json['expected_hour_rate'];
    tradeType = List.castFrom<dynamic, String>(json['trade_type']);
    availabilityDates = json['availability_dates'];
    experience = List.from(json['experience'])
        .map((e) => Experience.fromJson(e))
        .toList();
    licenses =
        List.from(json['licenses']).map((e) => License.fromJson(e)).toList();
    isDriving = json['is_driving'];
    licenseExpiryDate = json['license_expiry_date'];
    documents =
        List.from(json['documents']).map((e) => Document.fromJson(e)).toList();
    isApproved = json['is_approved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['dob'] = dob;
    data['expected_hour_rate'] = expectedHourRate;
    data['trade_type'] = tradeType;
    data['availability_dates'] = availabilityDates;
    data['experience'] = experience.map((e) => e.toJson()).toList();
    data['licenses'] = licenses.map((e) => e.toJson()).toList();
    data['is_driving'] = isDriving;
    data['license_expiry_date'] = licenseExpiryDate;
    data['documents'] = documents.map((e) => e.toJson()).toList();
    data['is_approved'] = isApproved;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
