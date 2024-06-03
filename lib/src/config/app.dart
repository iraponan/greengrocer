import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/theme.dart';
import 'package:greengrocer/src/screens/splash/splash.dart';

class AppGreengrocer extends StatelessWidget {
  const AppGreengrocer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quitanda Inovare TI',
      debugShowCheckedModeBanner: false,
      theme: ThemeProject.theme,
      home: const SplashScreen(),
    );
  }
}
