import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateJobTextField extends StatelessWidget {
  const CreateJobTextField({
    required this.controller,
    required this.hint,
    this.textInputType,
    this.errorText,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? textInputType;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.go,
      keyboardType: textInputType,
      controller: controller,
      onSubmitted: (String? value) {},
      decoration: InputDecoration(
        filled: true,
        fillColor: searchBarColor,
        errorText: errorText,
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11.r),
          borderSide: BorderSide.none, // No border
        ),
      ),
    );
  }
}
