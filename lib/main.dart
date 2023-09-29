import 'package:chat_gpt/screen/OnBoarding/on_boarding_screen.dart';
import 'package:chat_gpt/shared/providers/chats_provider.dart';
import 'package:chat_gpt/shared/providers/models_provider.dart';
import 'package:chat_gpt/shared/style/enum/enum.dart';
import 'package:chat_gpt/shared/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.ensureScreenSize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: ScreenUtil.defaultSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'Chat GPT',
              theme: getThemeData[AppTheme.darkTheme],
              darkTheme: getThemeData[AppTheme.darkTheme],
              themeMode: ThemeMode.dark,
              debugShowCheckedModeBanner: false,
              home: const OnBoardingScreen(),
            );
          }),
    );
  }
}
