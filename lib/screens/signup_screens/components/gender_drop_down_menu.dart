import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderDropDownMenu extends StatelessWidget {
  GenderDropDownMenu({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final List<String> genders = ['Male', 'Female', 'others'];
  final String? value;
  final ValueChanged<String?>? onChanged;


  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      isExpanded: true,
      style: tileHeader,
      underline: const Divider(
        height: 1,
        thickness: 2,
        color: Colors.black,
      ),
      icon: Material(
        color: Colors.transparent,
        shape: const CircleBorder(
          side: BorderSide(color: Colors.black, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            Icons.arrow_downward,
            color: Colors.black,
            size: 13.sp,
          ),
        ),
      ),
      hint: const Text('Choose your gender'),
      items: genders
          .map(
            (String value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
