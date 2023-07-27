import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkExperienceCard extends StatelessWidget {
  const WorkExperienceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/L&T.png',
              height: 45.h,
            ),
            SizedBox(
              width: 26.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'L&T Pvt Ltd.',
                  style: subtitle.copyWith(color: aboutGrey),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Delhi, India',
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
            )
          ],
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
          style: subtitle.copyWith(
            color: aboutGrey,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
