import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LongOutlineButton extends StatelessWidget {
  const LongOutlineButton({
    required this.text,
    this.onPressed,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStatePropertyAll(Size(double.infinity, 30.h)),
        side: const MaterialStatePropertyAll(
          BorderSide(
            color: primeryRed,
            width: 2,
          ),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8.r,
            ),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: 'Branding SF',
            fontWeight: FontWeight.w900,
            color: primeryRed,
          ),
        ),
      ),
    );
  }
}
