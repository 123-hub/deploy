import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/experience_model.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/parse_date_range.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddExperienceCard extends StatelessWidget {
  const AddExperienceCard({
    super.key,
    required this.experience,
    required this.onTap,
  });

  final ExperienceModel experience;
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
            experience.position,
            style: authInfoHeading,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    experience.companyName,
                    style: bottomSheetSubTitle,
                  ),
                  Text(
                    parceDateRange(experience.from, experience.to),
                    style: subtitle.copyWith(color: cardSubtitle),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                experience.description,
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
