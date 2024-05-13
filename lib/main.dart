import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthy_minder/socket/pusher_socket.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'package:healthy_minder/utils/themes.dart';
import 'package:healthy_minder/utils/translator.dart';

void main() async {
  await StorageHelper.init();
  String currentStep = StorageHelper.getCurrentStep();
  // await PusherSocket().init();
  runApp(MyApp(currentStep: currentStep));
}

class MyApp extends StatelessWidget {
  final String currentStep;

  const MyApp({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final initialRoute = _findInitialRoute(currentStep);
    return GetMaterialApp(
      getPages: HealthyRoutes.getPages(),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      // isLoggedIn ? HealthyRoutes.homePageRoute : HealthyRoutes.loginRoute,
      // initialRoute: HealthyRoutes.homePageRoute,
      builder: (context, child) => Container(
        // textDirection: TextDirection.ltr,
        child: child ?? Container(),
      ),
      // themeMode: ThemeMode.light,
      themeMode: StorageHelper.currentTheme(),
      translations: Translator(),
      initialBinding: InitialGetBinding(),
      locale: StorageHelper.getLanguage(),
      fallbackLocale: const Locale('en', 'US'),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }

  _findInitialRoute(String currentStep) {
    bool isLoggedIn = StorageHelper.isLoggedIn();
    if (!isLoggedIn) {
      return HealthyRoutes.loginRoute;
    }
    if (currentStep == 'register') {
      return HealthyRoutes.selectPlanRoute;
    } else {
      return HealthyRoutes.homePageRoute;
    }
  }
}
