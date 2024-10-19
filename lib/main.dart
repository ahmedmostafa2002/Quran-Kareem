import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_kareem/view/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

late SharedPreferences sharedPref;
String removeTashkeel(String text) {
  return text.replaceAll(RegExp(r'[\u064B-\u0652]'), '');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('ar'),
        title: "القرآن الكريم",
        theme: ThemeData(
          fontFamily: "OttomanFont",
        ),
        home: const SplashScreen());
  }
}
