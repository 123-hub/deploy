import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/license_model.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/parce_date.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class LabourLicenseCard extends StatelessWidget {
  const LabourLicenseCard({
    super.key,
    required this.license,
    required this.onTap,
  });

  final LicenseModel license;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: ListTile(
          title: Text(
            license.licenseName,
            style: authInfoHeading,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Text(
                'Expires on: ${parceDate(license.expiryDate)}',
                style: bottomSheetSubTitle,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                license.description,
                style: subtitle.copyWith(color: cardSubtitle),
              ),
            ],
          ),
          trailing: InkWell(
            onTap: onTap,
            child: const Icon(
              Icons.delete_outline,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
