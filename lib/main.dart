import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/client_dashboard_screen.dart';
import 'package:flutter_project_labour_app/screens/login_screens/login_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
