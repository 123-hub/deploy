import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: size.width * 0.08,
          width: size.width * 0.08,
          child: Image.asset("assets/images/logo_only.png"),
        ),
        Image.asset(
          'assets/images/notification.png',
          height: 25.h,
        ),
      ],
    );
  }
}
