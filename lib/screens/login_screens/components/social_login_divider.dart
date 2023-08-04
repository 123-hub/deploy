import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialLoginDivider extends StatelessWidget {
  const SocialLoginDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
            child: Divider(
          color: lightGrey,
        )),
        SizedBox(
          width: 37.w,
        ),
        Text(
          'OR',
          style: subtitle.copyWith(color: lightGrey),
        ),
        SizedBox(
          width: 37.w,
        ),
        const Expanded(
            child: Divider(
          color: lightGrey,
        )),
      ],
    );
  }
}
