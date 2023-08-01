import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    required this.onTap,
    super.key,
  });
  final VoidCallback onTap;

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
              padding: EdgeInsets.only(
                  right: 16.w, left: 16.w, bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 0.w,
                      vertical: 0.h,
                    ),
                    title: Text(
                      'ABC Company',
                      style: authInfoHeading,
                    ),
                    subtitle: Text(
                      'Delhi, India',
                      style: subtitle.copyWith(color: cardSubtitle),
                    ),
                    trailing: Text(
                      '\$28',
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
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: subtitle.copyWith(color: cardSubtitle),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Chip(
                        label: Text(
                          '3 Months',
                          style:
                              subtitle.copyWith(color: Colors.black),
                        ),
                        backgroundColor: lightBlue,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Chip(
                        label: Text(
                          'Labour',
                          style:
                              subtitle.copyWith(color: Colors.black),
                        ),
                        backgroundColor: searchBarColor,
                      ),
                    ],
                  )
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
