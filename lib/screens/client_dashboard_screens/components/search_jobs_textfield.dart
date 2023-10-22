import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobSearchTextField extends StatelessWidget {
  const JobSearchTextField({
    super.key,
    this.onSearch,
  });

  final ValueChanged<String>? onSearch;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          filled: true,
          fillColor: searchBarColor,
          contentPadding: EdgeInsets.only(bottom: 5.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11.r),
            borderSide: BorderSide.none, // No border
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: searchBarIconColor,
          ),
        ),
        onSubmitted: onSearch,
      ),
    );
  }
}
