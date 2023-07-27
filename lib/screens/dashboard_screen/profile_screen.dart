import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/screens/dashboard_screen/components/back_appbar.dart';
import 'package:flutter_project_labour_app/screens/dashboard_screen/components/work_experience_card.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 33.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            BackAppBar(),
            SizedBox(
              height: 30.h,
            ),
            CircleAvatar(
              radius: 48.r,
              backgroundImage: const AssetImage('assets/images/profile_2.png'),
            ),
            SizedBox(
              height: 26.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sheldon Schaden',
                  style: gilroy18sp,
                ),
                Icon(
                  Icons.edit_outlined,
                  size: 20.h,
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'Daily Labour at Xyz Construction',
              style: chatTileMessage,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 15.h,
                  color: cardSubtitle,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Texas City, USA',
                  style: subtitle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: cardSubtitle,
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                const Text(
                  '●',
                  style: TextStyle(color: cardSubtitle),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  'Contact Info',
                  style: subtitle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: contactInfo,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'About',
              style: tileHeader.copyWith(color: aboutGrey),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore .',
              style: subtitle.copyWith(
                color: aboutGrey,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Text(
                  'Expected Wage:',
                  style: tileHeader.copyWith(color: aboutGrey),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '\$28/hr:',
                  style: tileHeader.copyWith(
                      color: aboutGrey, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 13.h,
            ),
            const Divider(),
            SizedBox(
              height: 13.h,
            ),
            Text(
              'Work Experience',
              style: tileHeader.copyWith(color: aboutGrey),
            ),
            SizedBox(
              height: 15.h,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return const WorkExperienceCard();
              },
            )
          ],
        ),
      ),
    );
  }
}
