import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Logo',
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: 'Sansita',
          ),
        ),
        Icon(
          Icons.wb_sunny_outlined,
          weight: 2,
          size: 30.sp,
        )
      ],
    );
  }
}
