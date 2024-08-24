import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/page_routes.dart';
import 'package:greengrocer/src/config/theme.dart';
import 'package:greengrocer/src/routes/pages.dart';

class AppGreengrocer extends StatelessWidget {
  const AppGreengrocer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quitanda Inovare TI',
      debugShowCheckedModeBanner: false,
      theme: ThemeProject.theme,
      initialRoute: PageRoutes.splashRoute,
      getPages: AppPages.pages,
    );
  }
}
