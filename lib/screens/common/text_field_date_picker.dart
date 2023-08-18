import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldDatePicker extends StatelessWidget {
  const TextFieldDatePicker({
    super.key,
    required this.onTap,
    required this.controller,
    required this.hintText,
    required this.firstDate,
    required this.lastDate,
    required this.initialDate,
    this.errorMessage,
  });
  final TextEditingController controller;
  final ValueChanged<DateTime> onTap;
  final String hintText;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      
      style: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        icon: const Icon(Icons.calendar_month),
        errorText: errorMessage,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Gilroy',
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
        );
        if (pickedDate != null) {
          onTap(pickedDate);
        } else {
          debugPrint("Date is not selected");
        }
      },
    );
  }
}
