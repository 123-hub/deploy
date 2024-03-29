import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/contractor_document_model.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContractorDocumentCard extends StatelessWidget {
  const ContractorDocumentCard({
    super.key,
    required this.documentModel,
    required this.onDelete,
    this.onTap,
  });

  final ContractorDocumentModel documentModel;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: ListTile(
            title: Text(
              documentModel.ownerDrivingLicense!.startsWith('https')
                  ? documentModel.ownerDrivingLicense!.split("/").last
                  : documentModel.ownerDrivingLicense!,
              style: authInfoHeading,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  documentModel.insuranceLiability!.startsWith("http")
                      ? documentModel.insuranceLiability!.split('/').last
                      : documentModel.insuranceLiability!,
                  style: subtitle.copyWith(color: cardSubtitle),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  documentModel.businessLicense!.startsWith('http')
                      ? documentModel.insuranceLiability!.split("/").last
                      : documentModel.insuranceLiability!,
                  style: subtitle.copyWith(color: cardSubtitle),
                ),
              ],
            ),
            trailing: InkWell(
              onTap: onDelete,
              child: const Icon(
                Icons.delete_outline,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
