import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    required this.text,
    required this.isArrowPresent,
    this.onPressed,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isArrowPresent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130.w,
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        color: const Color(0xFFFF4E34),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Branding SF',
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              isArrowPresent
                  ? const Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
