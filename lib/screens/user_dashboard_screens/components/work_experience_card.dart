import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/experience.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/parce_date.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkExperienceCard extends StatelessWidget {
  const WorkExperienceCard({
    required this.experience,
    super.key,
  });
  final Experience experience;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.work_history_outlined,
              size: 40.h,
              color: aboutGrey,
            ),
            SizedBox(
              width: 26.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experience.position,
                  style: subtitle.copyWith(color: aboutGrey),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  experience.companyName,
                  style: subtitle.copyWith(color: cardSubtitle),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Chip(
                  label: Text(
                    "${parceDate(experience.from)} - ${parceDate(experience.to)}",
                    style: subtitle.copyWith(color: Colors.black),
                  ),
                  backgroundColor: lightBlue,
                ),
              ],
            )
          ],
        ),
        Text(
          experience.description,
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
