import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/license.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/parce_date.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LicenseCard extends StatelessWidget {
  const LicenseCard({
    required this.license,
    super.key,
  });
  final License license;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.badge,
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
                  license.licenseName,
                  style: subtitle.copyWith(color: aboutGrey),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Exp: ${parceDate(license.expiryDate)}',
                  style: subtitle.copyWith(color: cardSubtitle),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Chip(
                  label: Text(
                    "${parceDate(license.from)} - ${parceDate(license.to)}",
                    style: subtitle.copyWith(color: Colors.black),
                  ),
                  backgroundColor: lightBlue,
                ),
              ],
            )
          ],
        ),
        Text(
          license.description,
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
