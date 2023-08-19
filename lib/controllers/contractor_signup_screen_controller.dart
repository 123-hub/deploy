import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/contractor_document_model.dart';
import 'package:flutter_project_labour_app/util/endpoints.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ContractorSignUpScreenController extends GetxController {
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final dateTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final companyNameTextController = TextEditingController();
  final companyAddressTextController = TextEditingController();
  final companyPhoneNumberTextController = TextEditingController();
  final companyWebsiteTextController = TextEditingController();
  final companyFaxNumberTextController = TextEditingController();
  final businesslicenseNumberTextController = TextEditingController();
  final wcbNumberTextController = TextEditingController();
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;
  var isFirstNameValid = true.obs;
  var isLastNameValid = true.obs;
  var isPhoneNumberValid = true.obs;
  var isDOBValid = true.obs;
  var isPasswordValid = true.obs;
  var isConfirmPasswordValid = true.obs;
  var isCompanyNamevalid = true.obs;
  var isCompanyAddressvalid = true.obs;
  var isCompanyphoneNumbervalid = true.obs;
  var isCompanyWebsitevalid = true.obs;
  var isCompanyFaxNumbervalid = true.obs;
  var isbusinesslicenseNumbervalid = true.obs;
  var iswcbNumbervalid = true.obs;
  var firstNameErrorMessage = 'Enter your first name';
  var lastNameErrorMessage = 'Enter your last Name';
  var phoneNumberErrorMessage = 'Enter your phone number';
  var dobErrorMessage = 'Enter your date of birth';
  var passwordErrorMessage = 'Enter password';
  var confirmPasswordErrorMessage = 'Enter confirm password';
  var companyNameErrorMessage = 'Enter your Company name';
  var companyAddressErrorMessage = 'Enter your Company Address';
  var companyPhoneNumberErrorMessage = 'Enter your Company Phone number';
  var companyWebsiteErrorMessage = 'Enter your Company website';
  var companyFaxNumberErrorMessage = 'Enter your Company fax number';
  var businesslicenseNumberErrorMessage = 'Enter your business license';
  var wcbNumberErrorMessage = 'Enter your wcb number';
  RxList<ContractorDocumentModel> documents = <ContractorDocumentModel>[].obs;
  var dateOfBirth = DateTime.now();
  var otp = "";

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
    if (companyNameTextController.text.trim().isEmpty) {
      isCompanyNamevalid(false);
    } else {
      isCompanyNamevalid(true);
    }
    if (companyAddressTextController.text.trim().isEmpty) {
      isCompanyAddressvalid(false);
    } else {
      isCompanyAddressvalid(true);
    }
    if (companyPhoneNumberTextController.text.trim().isEmpty) {
      isCompanyphoneNumbervalid(false);
    } else {
      isCompanyphoneNumbervalid(true);
    }
    if (companyWebsiteTextController.text.trim().isEmpty) {
      isCompanyWebsitevalid(false);
    } else {
      isCompanyWebsitevalid(true);
    }
    if (companyFaxNumberTextController.text.trim().isEmpty) {
      isCompanyFaxNumbervalid(false);
    } else {
      isCompanyFaxNumbervalid(true);
    }
    if (businesslicenseNumberTextController.text.trim().isEmpty) {
      isbusinesslicenseNumbervalid(false);
    } else {
      isbusinesslicenseNumbervalid(true);
    }
    if (wcbNumberTextController.text.trim().isEmpty) {
      iswcbNumbervalid(false);
    } else {
      iswcbNumbervalid(true);
    }
    if (isCompanyNamevalid.value &&
        isCompanyAddressvalid.value &&
        isCompanyphoneNumbervalid.value &&
        isCompanyWebsitevalid.value &&
        isCompanyFaxNumbervalid.value &&
        isbusinesslicenseNumbervalid.value &&
        iswcbNumbervalid.value) {
      return true;
    } else {
      return false;
    }
  }

  bool addDocument(ContractorDocumentModel document) {
    if (!documents.contains(document)) {
      documents.add(document);
      notifyChildrens();
      return true;
    }
    showErrorSnackBar('Document already exists');
    return false;
  }

  void deleteDocument(ContractorDocumentModel documen) {
    documents.remove(documen);
    notifyChildrens();
  }

  void chageShowPassword() {
    showPassword(!showPassword.value);
  }

  void chageConfirmShowPassword() {
    showConfirmPassword(!showConfirmPassword.value);
  }

  Map<String, dynamic> getSignUpData() {
    return {
      "email": emailTextController.text.trim(),
      "password": passwordTextController.text.trim(),
      "first_name": firstNameTextController.text.trim(),
      "last_name": lastNameTextController.text.trim(),
      "phone_number": phoneNumberTextController.text.trim(),
      "date_of_birth":
          '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateOfBirth)}Z',
      "company_name": companyNameTextController.text.trim(),
      "company_address": companyAddressTextController.text.trim(),
      "company_phone_number": companyPhoneNumberTextController.text.trim(),
      "company_website": companyWebsiteTextController.text.trim(),
      "company_fax_number": companyFaxNumberTextController.text.trim(),
      "business_license_number":
          businesslicenseNumberTextController.text.trim(),
      "wcb_number": wcbNumberTextController.text.trim(),
      "documents": documents.map((element) => element.toJson()).toList(),
    };
  }

  Future<bool> sendOtp() async {
    var response = await http.post(
      Uri.parse(Endpoints.contractorOTP),
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
      Uri.parse(Endpoints.varifyContractorOTP),
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

  Future<bool> contractorSignup() async {
    printError(info: getSignUpData().toString());
    var response = await http.post(
      Uri.parse(Endpoints.contractorSignup),
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
