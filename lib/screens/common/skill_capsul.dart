import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkillCapsule extends StatelessWidget {
  const SkillCapsule({
    required this.name,
    required this.onDelete,
    super.key,
  });
  final String name;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      backgroundColor: primaryRed,
      deleteIcon: Material(
        color: Colors.transparent,
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            Icons.close,
            size: 13.sp,
          ),
        ),
      ),
      deleteIconColor: Colors.white,
      label: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onDeleted: onDelete,
    );
  }
}
