import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobSearchBar extends StatelessWidget {
  const JobSearchBar({
    super.key,
    required this.searchTextController,
    required this.readOnly,
    this.onTap,
  });

  final TextEditingController searchTextController;
  final VoidCallback? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        readOnly: readOnly,
        onTap: onTap,
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
