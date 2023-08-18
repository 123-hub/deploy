import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddDocument extends StatelessWidget {
  const AddDocument({
    super.key,
    required this.title,
    required this.onTap,
  });

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: authInfoHeading,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 8.h, left: 8.w),
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(
                side: BorderSide(color: Colors.black, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 13.sp,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
