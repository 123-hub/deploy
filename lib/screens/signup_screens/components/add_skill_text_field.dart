import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSkillTextField extends StatelessWidget {
  const AddSkillTextField({
    super.key,
    required this.skillTextController,
    required this.onTap,
    required this.onSubmit,
  });

  final TextEditingController skillTextController;
  final VoidCallback onTap;
  final ValueChanged<String>? onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: skillTextController,
      textInputAction: TextInputAction.go,
      onFieldSubmitted: onSubmit,
      style: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: onTap,
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(
              side: BorderSide(color: Colors.black, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 13.sp,
              ),
            ),
          ),
        ),
        suffixIconConstraints: BoxConstraints(maxWidth: 30.sp),
        hintText: 'Enter Qualifications',
        hintStyle: TextStyle(
          fontFamily: 'Gilroy',
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}
