import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.emailTextController,
    required this.hintText,
    required this.isPasswordField,
    required this.primaryIcon,
    this.showPassword,
    this.visibilityButton,
  });

  final TextEditingController emailTextController;
  final IconData primaryIcon;
  final String hintText;
  final bool isPasswordField;
  final bool? showPassword;
  final VoidCallback? visibilityButton;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailTextController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      obscureText: isPasswordField ? !showPassword! : false,
      decoration: InputDecoration(
        icon: Icon(primaryIcon),
        suffixIcon: isPasswordField
            ? IconButton(
                onPressed: visibilityButton,
                icon: showPassword!
                    ? const Icon(Icons.visibility_outlined)
                    : const Icon(
                        Icons.visibility_off_outlined,
                      ),
              )
            : null,
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
    );
  }
}
