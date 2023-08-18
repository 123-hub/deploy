import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/document_model.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocumentCard extends StatelessWidget {
  const DocumentCard({
    super.key,
    required this.documentModel,
    required this.onDelete,
  });

  final DocumentModel documentModel;
  final VoidCallback onDelete;

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
            documentModel.documentName,
            style: authInfoHeading,
          ),
          subtitle: Text(
            documentModel.description,
            style: subtitle.copyWith(color: cardSubtitle),
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
    );
  }
}
