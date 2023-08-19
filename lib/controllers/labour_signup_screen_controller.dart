import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/document_model.dart';
import 'package:flutter_project_labour_app/models/experience_model.dart';
import 'package:flutter_project_labour_app/models/license_model.dart';
import 'package:flutter_project_labour_app/util/endpoints.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LabourSignupScreenController extends GetxController {
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final dateTextController = TextEditingController();
  final expectedRateTextController = TextEditingController();
  final lisenceExpiryTextController = TextEditingController();
  final emailTextController = TextEditingController();
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;
  var date = Rx<String?>(null);
  RxList<bool> days = List.filled(7, false).obs;
  var canDrive = false.obs;
  var tradeTypes = <String>[].obs;
  var otp = '';
  RxList<DocumentModel> documents = <DocumentModel>[].obs;
  RxList<ExperienceModel> experiences = <ExperienceModel>[].obs;
  RxList<LicenseModel> licenses = <LicenseModel>[].obs;
  var isFirstNameValid = true.obs;
  var isLastNameValid = true.obs;
  var isPhoneNumberValid = true.obs;
  var isDOBValid = true.obs;
  var isPasswordValid = true.obs;
  var isConfirmPasswordValid = true.obs;
  var isHourlyRateValid = true.obs;
  var isexpiryDateValid = true.obs;
  var firstNameErrorMessage = 'Enter your first name';
  var lastNameErrorMessage = 'Enter your last Name';
  var phoneNumberErrorMessage = 'Enter your phone number';
  var dobErrorMessage = 'Enter your date of birth';
  var passwordErrorMessage = 'Enter password';
  var confirmPasswordErrorMessage = 'Enter confirm password';
  var hourlyRateErrorMessage = 'Enter your hourly Rate';
  var expiryDateErrorMessage = 'Enter Expiry Date';
  var dateOfBirth = DateTime.now();
  var licencExpiry = DateTime.now();

  bool isFirstPageValid() {
    if (firstNameTextController.text.trim().isEmpty) {
      isFirstNameValid(false);
    } else {
      isFirstNameValid(true);
    }
    if (lastNameTextController.text.trim().isEmpty) {
      isLastNameValid(false);
    } else {
      isLastNameValid(true);
    }
    if (phoneNumberTextController.text.trim().isEmpty) {
      isPhoneNumberValid(false);
    } else {
      isPhoneNumberValid(true);
    }
    if (dateTextController.text.trim().isEmpty) {
      isDOBValid(false);
    } else {
      isDOBValid(true);
    }
    if (passwordTextController.text.trim().isEmpty) {
      isPasswordValid(false);
    } else {
      isPasswordValid(true);
    }
    if (confirmPasswordTextController.text.trim().isEmpty) {
      isConfirmPasswordValid(false);
    } else {
      isConfirmPasswordValid(true);
    }
    if (confirmPasswordTextController.text != passwordTextController.text) {
      isConfirmPasswordValid(false);
      confirmPasswordErrorMessage = 'Password not matching';
    } else {
      isConfirmPasswordValid(true);
      confirmPasswordErrorMessage = 'Enter confirm password';
    }
    if (isFirstNameValid.value &&
        isLastNameValid.value &&
        isPhoneNumberValid.value &&
        isDOBValid.value &&
        isPasswordValid.value &&
        isConfirmPasswordValid.value) {
      return true;
    } else {
      return false;
    }
  }

  bool isSecondPageValid() {
    if (expectedRateTextController.text.trim().isEmpty) {
      isHourlyRateValid(false);
    } else {
      isHourlyRateValid(true);
    }
    if (canDrive.value && lisenceExpiryTextController.text.trim().isEmpty) {
      isexpiryDateValid(false);
    } else {
      isexpiryDateValid(true);
    }
    notifyChildrens();
    if (days.where((element) => element).isEmpty) {
      print("Entered");
      showErrorSnackBar('Select atleast one day');
      return false;
    }
    if (isHourlyRateValid.value) {
      if (canDrive.value && isexpiryDateValid.value) {
        return false;
      }
      return true;
    }
    return false;
  }

  String getDays() {
    var weekdays = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    var added = <String>[];
    for (var i = 0; i < 7; i++) {
      if (days[i]) {
        added.add(weekdays[i]);
      }
    }
    var result = '';
    for (var i = 0; i < added.length - 1; i++) {
      result += '${added[i]}, ';
    }
    result += added[added.length - 1];
    return result;
  }

  Map<String, dynamic> getSignUpData() {
    return {
      "email": emailTextController.text.trim(),
      "password": passwordTextController.text.trim(),
      "first_name": firstNameTextController.text.trim(),
      "last_name": lastNameTextController.text.trim(),
      "phone_number": phoneNumberTextController.text.trim(),
      "dob": '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateOfBirth)}Z',
      "expected_hour_rate": double.parse(expectedRateTextController.text),
      "trade_type": [...tradeTypes.map((element) => element)],
      "availability_dates": getDays(),
      "experience": experiences.map((element) => element.toJson()).toList(),
      "licenses": licenses.map((element) => element.toJson()).toList(),
      "is_driving": canDrive.value,
      "license_expiry_date": licencExpiry.difference(DateTime.now()).inDays > 0
          ? '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(licencExpiry)}Z'
          : null,
      "documents": documents.map((element) => element.toJson()).toList(),
    };
  }

  bool addTradeType(String tradeType) {
    if (tradeType.trim() != '') {
      if (tradeTypes.contains(tradeType)) {
        return false;
      }
      tradeTypes.add(tradeType);
      notifyChildrens();
      return true;
    }
    return false;
  }

  bool addExperience(ExperienceModel experience) {
    if (!experiences.contains(experience)) {
      experiences.add(experience);
      notifyChildrens();
      return true;
    }
    showErrorSnackBar('Experience already exists');
    return false;
  }

  bool addLicense(LicenseModel license) {
    if (!licenses.contains(license)) {
      licenses.add(license);
      notifyChildrens();
      return true;
    }
    showErrorSnackBar('License already exists');
    return false;
  }

  bool addDocument(DocumentModel document) {
    if (documents
        .where((DocumentModel element) =>
            element.documentName == document.documentName)
        .isEmpty) {
      documents.add(document);
      notifyChildrens();
      return true;
    }
    showErrorSnackBar('Document already exists');
    return false;
  }

  void deleteDocument(DocumentModel documen) {
    documents.remove(documen);
    notifyChildrens();
  }

  void deleteExperience(ExperienceModel experience) {
    experiences.remove(experience);
    notifyChildrens();
  }

  void deleteLicense(LicenseModel license) {
    licenses.remove(license);
    notifyChildrens();
  }

  

  void deleteTradeType(String tradeType) {
    tradeTypes.remove(tradeType);
    notifyChildrens();
  }

  void chageShowPassword() {
    showPassword(!showPassword.value);
  }

  void chageConfirmShowPassword() {
    showConfirmPassword(!showConfirmPassword.value);
  }

  void changeCanDrive(int? index) {
    if (index != null) {
      canDrive(index == 0 ? true : false);
      if (canDrive.value == false) {
        lisenceExpiryTextController.clear();
      }
    }
  }

  void selectDays(int day) {
    debugPrint('selected day index $day');
    if (day == 7) {
      day = 0;
    }
    days[day] = !days[day];
    notifyChildrens();
  }

  Future<bool> sendOtp() async {
    var response = await http.post(
      Uri.parse(Endpoints.labourOTP),
      headers: Endpoints.jsonHeader,
      body: jsonEncode({
        "email": emailTextController.text.trim(),
      }),
    );
    if (response.statusCode < 299) {
      showDoneSnackBar('OTP Sent Successfully');
      return true;
    } else {
      showErrorSnackBar('Failed to send email');
      return false;
    }
  }

  Future<bool> verifyOtp() async {
    if (otp.trim().isEmpty || otp.length != 5) {
      showErrorSnackBar('Enter valid OTP');
      return false;
    }
    debugPrint('The email is ${emailTextController.text.trim()}');
    var response = await http.post(
      Uri.parse(Endpoints.varifyLabourOTP),
      headers: Endpoints.jsonHeader,
      body: jsonEncode({"email": emailTextController.text.trim(), "otp": otp}),
    );
    if (response.statusCode < 299) {
      var body = jsonDecode(response.body);
      if (body['success'] == true) {
        showDoneSnackBar('OTP Verified Successfully');
        return true;
      } else {
        showErrorSnackBar('Invalid OTP');
        return false;
      }
    } else {
      debugPrint(response.body);
      showErrorSnackBar('Some Problem occured');
      return false;
    }
  }

  Future<bool> labourSignUp() async {
    printError(info: getSignUpData().toString());
    var response = await http.post(
      Uri.parse(Endpoints.labourSignup),
      headers: Endpoints.jsonHeader,
      body: jsonEncode(getSignUpData()),
    );
    if (response.statusCode < 299) {
      showDoneSnackBar('Account Made Succesfully');
      return true;
    } else {
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      showErrorSnackBar('Some Problem occured');
      return false;
    }
  }
  
}
