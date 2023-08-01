import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobDescTile extends StatelessWidget {
  const JobDescTile({
    required this.icon,
    required this.text,
    super.key,
  });
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: primeryRed,
        ),
        SizedBox(
          height: 13.h,
        ),
        Text(
          text,
          style: subtitle.copyWith(
            color: jobDescTileTextGrey,
          ),
        ),
      ],
    );
  }
}
