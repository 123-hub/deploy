import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/job.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobCardWithoutTag extends StatelessWidget {
  const JobCardWithoutTag({
    required this.job,
    required this.onTap,
    super.key,
  });
  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: searchBarColor),
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 0.w,
                      vertical: 0.h,
                    ),
                    title: Text(
                      job.name,
                      style: authInfoHeading,
                    ),
                    subtitle: Text(
                      job.enterLocation,
                      style: subtitle.copyWith(color: cardSubtitle),
                    ),
                    trailing: Text(
                      '\$${job.salaryRange}',
                      style: gilroy20sp,
                    ),
                  ),
                  Text(
                    'Description',
                    style: subtitle.copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    job.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: subtitle.copyWith(color: cardSubtitle),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        )
      ],
    );
  }
}
