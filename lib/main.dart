import 'package:chat_gpt/screen/OnBoarding/on_boarding_screen.dart';
import 'package:chat_gpt/shared/style/enum/enum.dart';
import 'package:chat_gpt/shared/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ScreenUtil.ensureScreenSize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Chat GPT',
            theme: getThemeData[AppTheme.lightTheme],
            darkTheme: getThemeData[AppTheme.lightTheme],
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const OnBoardingScreen(),
          );
        });
  }
}
