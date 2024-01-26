import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_labour_app/screens/start_up_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // HttpOverrides.global = MyHttpOverrides();
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
                  secondary: primaryRed,
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
      child: const StartUpScreen(),
    );
  }
}
