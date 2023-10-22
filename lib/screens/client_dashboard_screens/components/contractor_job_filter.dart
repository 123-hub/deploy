import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_job_controller.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/skill_capsul.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> contractorJobFilter(
  BuildContext context,
  ContractorJobController controller,
) {
  var skillTextController = TextEditingController();
  var locationTextController = TextEditingController();
  locationTextController.text = controller.filterLocation;
  List<String> skills = [...controller.filterSkills];

  return showModalBottomSheet(
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter myState) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filters',
                    style: bottomSheetTitle,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    'Enter Qualifications',
                    style: bottomSheetSubTitle,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextField(
                    textInputAction: TextInputAction.go,
                    controller: skillTextController,
                    onSubmitted: (String? value) {
                      if (value != null && value.trim().isNotEmpty) {
                        myState(() {
                          skills.add(value);
                          skillTextController.clear();
                        });
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: searchBarColor,
                      hintText: 'Enter Qualifications',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          var value = skillTextController.text;
                          if (value.isNotEmpty) {
                            myState(() {
                              skills.add(value);
                              skillTextController.clear();
                            });
                          }
                        },
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.r),
                        borderSide: BorderSide.none, // No border
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: skills
                        .map(
                          (String element) => SkillCapsule(
                            name: element,
                            onDelete: () {
                              myState(() {
                                skills.remove(element);
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Enter locations',
                    style: bottomSheetSubTitle,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 45.h,
                    child: TextField(
                      controller: locationTextController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: searchBarColor,
                        hintText: 'Type To Search for location',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.r),
                          borderSide: BorderSide.none, // No border
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  LongButton(
                    text: 'Apply filters',
                    onPressed: () {
                      controller.filterSkills.value = skills;
                      var location = locationTextController.text.trim();
                      controller.filterLocation =
                          location.isEmpty ? '' : location;
                      controller.applyFilter();
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}
