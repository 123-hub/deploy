import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/endpoints.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController extends GetxController {
  var emailController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  var isPasswordValid = true.obs;
  var isConfirmPasswordValid = true.obs;
  var passwordErrorMessage = 'Enter a value';
  var confirmPasswordErrorMessage = 'Enter a value';
  var isLoading = false.obs;
  var otp = '';
  var userType = '';
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;

  bool checkPasswordFields() {
    if (passwordTextController.text.trim().isEmpty) {
      isPasswordValid(false);
    } else {
      isPasswordValid(true);
    }
    if (confirmPasswordTextController.text.trim().isEmpty) {
      confirmPasswordErrorMessage = 'Enter a value';
      isConfirmPasswordValid(false);
    } else {
      isConfirmPasswordValid(true);
    }
    if (isPasswordValid.value && isConfirmPasswordValid.value) {
      return true;
    } else {
      return false;
    }
  }

  bool checkPasswordSame() {
    if (passwordTextController.text.trim() !=
        confirmPasswordTextController.text.trim()) {
      confirmPasswordErrorMessage = 'Password not matching';
      isConfirmPasswordValid(false);
    } else {
      isConfirmPasswordValid(true);
    }
    if (isConfirmPasswordValid.value) {
      return true;
    } else {
      return false;
    }
  }

  void changeShowPassword() {
    showPassword(!showPassword.value);
  }

  void changeShowConfirmPassword() {
    showConfirmPassword(!showConfirmPassword.value);
  }

  set role(String role) {
    userType = role;
  }

  Future<bool> sendOtp() async {
    isLoading(true);
    var response = await http.post(
      Uri.parse(
        userType == 'labour'
            ? Endpoints.labourOTPReset
            : Endpoints.contractorOTPReset,
      ),
      headers: Endpoints.jsonHeader,
      body: jsonEncode({
        "email": emailController.text.trim(),
      }),
    );
    isLoading(false);
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
    isLoading(true);
    debugPrint('The email is ${emailController.text.trim()}');
    var response = await http.post(
      Uri.parse(
        userType == 'labour'
            ? Endpoints.verifyLabourOTPReset
            : Endpoints.verifyContractorOTPReset,
      ),
      headers: Endpoints.jsonHeader,
      body: jsonEncode(
        {
          "email": emailController.text.trim(),
          "otp": otp,
        },
      ),
    );
    isLoading(false);
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
      showErrorSnackBar('Some Problem occurred');
      return false;
    }
  }

  Future<bool> resetPassword() async {
    isLoading(true);
    var response = await http.post(
      Uri.parse(
        userType == 'labour'
            ? Endpoints.labourResetPassword
            : Endpoints.contractorResetPassword,
      ),
      headers: Endpoints.jsonHeader,
      body: jsonEncode(
        {
          "email": emailController.text.trim(),
          "password": passwordTextController.text.trim(),
        },
      ),
    );
    isLoading(false);
    if (response.statusCode < 299) {
      showDoneSnackBar('Password Changed');
      return true;
    } else if (response.statusCode < 499) {
      showErrorSnackBar(jsonDecode(response.body)['message']);
      return false;
    } else {
      showErrorSnackBar('Some problem occurred');
      return false;
    }
  }
}
