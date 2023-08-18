import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/login_response.dart';
import 'package:flutter_project_labour_app/util/endpoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

enum Role {
  labour,
  contractor,
}

class LoginScreenController extends GetxController {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  var isEmailValid = true.obs;
  var isPasswordValid = true.obs;
  var emailErrorMessage = '';
  var passwordErrorMessage = '';
  var role = Rx<String?>(null);
  var loginResponse = Rx<LoginResponse?>(null);
  var showPassword = false.obs;

  void chageShowPassword() {
    showPassword(!showPassword.value);
  }

  bool areTextFieldValid() {
    if (emailTextController.text.trim().isEmpty) {
      isEmailValid(false);
      emailErrorMessage = 'Enter a valid email';
    } else {
      isEmailValid(true);
      emailErrorMessage = '';
    }
    if (passwordTextController.text.trim().isEmpty) {
      isPasswordValid(false);
      passwordErrorMessage = 'Enter a valid password';
    } else {
      isPasswordValid(true);
      passwordErrorMessage = '';
    }
    notifyChildrens();
    if (!isEmailValid.value || !isPasswordValid.value) {
      return false;
    }
    return true;
  }

  void onRoleChange(String? value) {
    role(value);
  }

  void showErrorSnackBar(String message) {
    Get.showSnackbar(
      GetSnackBar(
        title: 'Error',
        message: message,
        icon: const Icon(Icons.error),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future loginUser() async {
    if (role.value == null) {
      showErrorSnackBar('Choose a role');
      return;
    }
    String url = (role.value == 'labour')
        ? Endpoints.labourLogin
        : Endpoints.contractorLogin;
    var response = await http.post(
      Uri.parse(url),
      headers: Endpoints.jsonHeader,
      body: jsonEncode({
        "email": emailTextController.text.trim(),
        "password": passwordTextController.text.trim(),
      }),
    );
    if (response.statusCode < 299) {
      loginResponse.value =
          LoginResponse.fromJson(jsonDecode(response.body)['data']);
      debugPrint(loginResponse.value.toString());
    } else if (response.statusCode < 499) {
      isPasswordValid(false);
      passwordErrorMessage = 'Wrong password';
    } else if (response.statusCode < 599) {
      isEmailValid(false);
      emailErrorMessage = 'Enter valid email';
    }
  }
}