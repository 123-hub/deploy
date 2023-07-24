import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/screens/login_screen/login_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFFAFAFA),
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Colors.black,
                  secondary: primeryRed,
                ),
            textSelectionTheme: const TextSelectionThemeData(
              selectionColor: Colors.grey,
              cursorColor: Colors.black,
              selectionHandleColor: Colors.black,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: LoginScreen(),
    );
  }
}
