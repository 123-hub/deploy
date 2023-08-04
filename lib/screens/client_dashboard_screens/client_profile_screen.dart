import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/screens/common/company_info_tile.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/back_appbar.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

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
            const Divider(),
            SizedBox(
              height: 13.h,
            ),
            Text(
              'Company Info',
              style: tileHeader.copyWith(color: aboutGrey),
            ),
            SizedBox(
              height: 15.h,
            ),
            const CompanyInfoTile(
              title: 'Website',
              value: 'www.larsentoubro.com',
            ),
            SizedBox(
              height: 13.h,
            ),
            const CompanyInfoTile(
              title: 'Founded',
              value: '2018',
            ),
            SizedBox(
              height: 13.h,
            ),
            const CompanyInfoTile(
              title: 'Size',
              value: '400 Employee',
            ),
            SizedBox(
              height: 30.h,
            ),
            const Divider(),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'Recently Hired',
              style: tileHeader.copyWith(color: aboutGrey),
            ),
            SizedBox(
              height: 22.h,
            ),
            Row(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          const AssetImage('assets/images/worker.png'),
                      radius: 30.r,
                    ),
                    Text('Mason Baxter',
                        style: gilroy12_600.copyWith(color: aboutGrey)),
                  ],
                ),
                SizedBox(
                  width: 25.w,
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          const AssetImage('assets/images/worker.png'),
                      radius: 30.r,
                    ),
                    Text('Mason Baxter',
                        style: gilroy12_600.copyWith(color: aboutGrey)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
