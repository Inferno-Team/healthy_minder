import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthy_minder/socket/pusher_socket.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'package:healthy_minder/utils/translator.dart';

void main() async {
  await GetStorage.init();
  await PusherSocket().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = StorageHelper.isLoggedIn();
    return GetMaterialApp(
      getPages: HealthyRoutes.getPages(),
      debugShowCheckedModeBanner: false,
      initialRoute:
          isLoggedIn ? HealthyRoutes.homePageRoute : HealthyRoutes.welcomeRoute,
      builder: (context, child) => Directionality(
        textDirection: TextDirection.ltr,
        child: child ?? Container(),
      ),
      themeMode: StorageHelper.currentTheme(),
      translations: Translator(),
      initialBinding: InitialGetBinding(),
      locale: StorageHelper.getLanguage(),
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
