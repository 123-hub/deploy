import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorSnackBar(String message) {
    Get.showSnackbar(
      GetSnackBar(
        title: 'Error',
        message: message,
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showDoneSnackBar(String message) {
    Get.showSnackbar(
      GetSnackBar(
        title: 'Success',
        message: message,
        icon: const Icon(
          Icons.verified,
          color: Colors.green,
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }