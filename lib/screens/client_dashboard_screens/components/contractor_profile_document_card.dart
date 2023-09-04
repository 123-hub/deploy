import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/contractor_document.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/parce_date.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContractorProfileDocumentCard extends StatelessWidget {
  const ContractorProfileDocumentCard({
    required this.document,
    super.key,
  });
  final ContractorDocument document;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.insert_drive_file_outlined,
              size: 40.h,
              color: aboutGrey,
            ),
            SizedBox(
              width: 26.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.ownerDrivingLicense,
                  style: subtitle.copyWith(color: aboutGrey),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Uploaded at: ${parceDate(document.createdAt ?? '')}',
                  style: subtitle.copyWith(color: cardSubtitle),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Chip(
                  label: Text(
                    document.documentUrl,
                    style: subtitle.copyWith(color: Colors.black),
                  ),
                  backgroundColor: lightBlue,
                ),
              ],
            )
          ],
        ),
        Text(
          document.insuranceLiability,
          style: subtitle.copyWith(
            color: aboutGrey,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
