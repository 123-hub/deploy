import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserSearchImage extends StatelessWidget {
  const UserSearchImage({
    required this.image,
    required this.rating,
    super.key,
  });
  final String image;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      child: Stack(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: 35.r,
          ),
          Positioned(
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: ratingYellow,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ]),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.black,
                    size: 15.h,
                  ),
                  Text(rating.toString())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
