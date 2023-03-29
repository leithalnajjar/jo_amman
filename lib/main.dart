import 'dart:io';

import 'package:jo_amman/config/messaging_config.dart';
import 'package:jo_amman/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jo_amman/config/app_themes.dart';
import 'package:jo_amman/config/binding.dart';
import 'package:jo_amman/config/app_http_overrides.dart';
import 'package:jo_amman/config/shared_prefs_client.dart';
import 'package:jo_amman/config/translations.dart';
import 'package:jo_amman/controllers/app_controller.dart';
import 'package:jo_amman/ui/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefsClient.init();
  HttpOverrides.global = AppHttpOverrides();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  MessagingConfig.init();
  runApp(const JoAmman());
}

class JoAmman extends StatefulWidget {
  const JoAmman({super.key});

  @override
  State<JoAmman> createState() => _JoAmmanState();
}

class _JoAmmanState extends State<JoAmman> {
  final AppController _controller = AppController.to;

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: Binding(),
        translations: Translation(),
        locale: Locale(sharedPrefsClient.language),
        fallbackLocale: const Locale('en'),
        theme: AppThemes(context).appThemeData[AppTheme.lightTheme],
        darkTheme: AppThemes(context).appThemeData[AppTheme.darkTheme],
        themeMode: ThemeMode.light,
        showSemanticsDebugger: false,
        home: const SplashScreen(),
      ),
    );
  }
}
