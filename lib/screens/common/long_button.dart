import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LongButton extends StatelessWidget {
  const LongButton({
    required this.text,
    this.onPressed,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      color: const Color(0xFFFF4E34),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: 'Branding SF',
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
