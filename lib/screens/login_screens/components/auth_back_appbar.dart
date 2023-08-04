import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuthBackAppBar extends StatelessWidget {
  const AuthBackAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(
              side: BorderSide(color: Colors.black, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25.sp,
                weight: 2,
              ),
            ),
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
