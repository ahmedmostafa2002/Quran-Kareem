import 'package:alquran_alkareem/view/home.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Image.asset('assets/images/quran.jpg'),
        animationDuration: const Duration(seconds: 1),
        splashIconSize: 200,
        duration: 1000,
        backgroundColor: const Color.fromRGBO(255, 250, 246, 1),
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: const HomePage());
  }
}
