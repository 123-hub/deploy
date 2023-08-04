import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobSearchBar extends StatelessWidget {
  const JobSearchBar({
    super.key,
    required this.searchTextController,
  });

  final TextEditingController searchTextController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: searchTextController,
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
          suffixIcon: const Icon(
            Icons.mic,
            color: searchBarIconColor,
          ),
        ),
      ),
    );
  }
}

