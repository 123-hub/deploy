import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({
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
        Image.asset(
          'assets/images/notification.png',
          height: 25.h,
        ),
      ],
    );
  }
}
