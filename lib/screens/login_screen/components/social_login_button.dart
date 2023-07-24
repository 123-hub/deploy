import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    required this.name,
    required this.color,
    required this.image,
    this.onPressed,
    super.key,
  });

  final String name;
  final Color color;
  final String image;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        side: BorderSide(
          color: color,
          width: 2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 24.h,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              'Login with $name',
              style: TextStyle(
                color: color,
                fontSize: 14.sp,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
