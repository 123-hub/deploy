import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';

class CompanyInfoTile extends StatelessWidget {
  const CompanyInfoTile({
    required this.title,
    required this.value,
    super.key,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: gilroy12_600.copyWith(color: aboutGrey),
        ),
        Text(
          value,
          style: gilroy12_400.copyWith(color: aboutGrey),
        ),
      ],
    );
  }
}
