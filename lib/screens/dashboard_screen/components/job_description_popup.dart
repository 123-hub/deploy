import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/screens/common/bullet_pointes.dart';
import 'package:flutter_project_labour_app/screens/common/company_info_tile.dart';
import 'package:flutter_project_labour_app/screens/common/job_desc_tile.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> jobDescriptionPopUp(BuildContext context) {
  return showModalBottomSheet(
    useSafeArea: true,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.symmetric(horizontal: 33.w),
      height: MediaQuery.of(context).size.height * 0.85,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/L&T.png',
                      height: 80.h,
                    ),
                    SizedBox(
                      width: 39.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'L&T Pvt Ltd.',
                          style: authInfoHeading.copyWith(color: subtitleGrey),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Delhi, India',
                          style: subtitle.copyWith(color: cardSubtitle),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          children: [
                            Chip(
                              label: Text(
                                '3 Months',
                                style: subtitle.copyWith(color: Colors.black),
                              ),
                              backgroundColor: lightBlue,
                            ),
                            SizedBox(
                              width: 9.w,
                            ),
                            Chip(
                              label: Text(
                                'Labour',
                                style: subtitle.copyWith(color: Colors.black),
                              ),
                              backgroundColor: searchBarColor,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 29.h,
                ),
                Container(
                  height: 104.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: searchBarColor),
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const JobDescTile(
                        icon: Icons.work_outline,
                        text: 'Full Time',
                      ),
                      VerticalDivider(
                        indent: 15.h,
                        endIndent: 15.h,
                      ),
                      const JobDescTile(
                        icon: Icons.attach_money,
                        text: '\$28/month',
                      ),
                      VerticalDivider(
                        indent: 15.h,
                        endIndent: 15.h,
                      ),
                      const JobDescTile(
                        icon: Icons.location_on_outlined,
                        text: 'Delhi, India',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  'Description',
                  style: gilroy12_600.copyWith(color: jobDescTileTextGrey),
                ),
                SizedBox(
                  height: 9.h,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: gilroy12_400.copyWith(
                    color: aboutGrey,
                  ),
                ),
                SizedBox(
                  height: 21.h,
                ),
                const Divider(),
                SizedBox(
                  height: 19.h,
                ),
                Text(
                  'Preferred  Experience',
                  style: gilroy12_600.copyWith(color: jobDescTileTextGrey),
                ),
                SizedBox(
                  height: 9.h,
                ),
                const UnorderedList([
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed amet, consectetur adipiscing, tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut',
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed amet, consectetur adipiscing',
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed amet, consectetur adipiscing',
                ]),
                SizedBox(
                  height: 21.h,
                ),
                const Divider(),
                SizedBox(
                  height: 19.h,
                ),
                Text(
                  'Company Info',
                  style: gilroy12_600.copyWith(color: jobDescTileTextGrey),
                ),
                SizedBox(
                  height: 9.h,
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
                  height: 80.h,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24.h,
            child: Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8.r,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Icon(
                      Icons.bookmark_border,
                      color: Colors.black,
                      size: 25.h,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                MaterialButton(
                  onPressed: () {},
                  minWidth: MediaQuery.of(context).size.width * 0.65,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  color: const Color(0xFFFF4E34),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Text(
                      'Apply For This Job',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
