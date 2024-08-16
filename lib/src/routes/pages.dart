import 'package:get/get.dart';
import 'package:greengrocer/src/bindings/home.dart';
import 'package:greengrocer/src/helpers/utils/consts.dart';
import 'package:greengrocer/src/screens/auth/sing_in.dart';
import 'package:greengrocer/src/screens/auth/sing_up.dart';
import 'package:greengrocer/src/screens/base/base_screen.dart';
import 'package:greengrocer/src/screens/splash/splash.dart';

mixin AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PageRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PageRoutes.signInRoute,
      page: () => const SingInScreen(),
    ),
    GetPage(
      name: PageRoutes.signUpRoute,
      page: () => const SingUpScreen(),
    ),
    GetPage(
      name: PageRoutes.baseRoute,
      page: () => const BaseScreen(),
      bindings: [
        HomeBinding(),
      ],
    ),
  ];
}
