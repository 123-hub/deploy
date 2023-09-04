import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/job.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    required this.onTap,
    required this.job,
    super.key,
  });
  final VoidCallback? onTap;
  final Job job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
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
                  Wrap(
                    spacing: 10,
                    children: [
                      for (int i = 0; i < job.skills.length; i++)
                        Chip(
                          label: Text(
                            job.skills[i],
                            style: subtitle.copyWith(color: Colors.black),
                          ),
                          backgroundColor:
                              i % 2 == 0 ? lightBlue : searchBarColor,
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          )
        ],
      ),
    );
  }
}
