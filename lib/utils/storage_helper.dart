
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthy_minder/models/saved_user.dart';
import 'package:healthy_minder/utils/constances.dart';

class StorageHelper {
  static void login(String token) {
    GetStorage storage = GetStorage();
    storage.write(Constance.loginState, true);
    storage.write(Constance.tokenValue, token);
  }

  static bool isLoggedIn() {
    GetStorage storage = GetStorage();
    return storage.read(Constance.loginState) ?? false;
  }

  static String getToken() {
    GetStorage storage = GetStorage();
    return storage.read(Constance.tokenValue) ?? "";
  }

  static SavedUser getUser() {
    GetStorage storage = GetStorage();
    return storage.read(Constance.savedUser) ?? SavedUser.empty();
  }

  static String? getSavedLanguage() {
    GetStorage storage = GetStorage();
    String? lang = storage.read(Constance.languageValue);
    return lang;
  }

  static Locale? getLanguage() {
    String? lang = getSavedLanguage();
    //null safety
    if (lang == null) {
      String? ln = Get.deviceLocale?.languageCode;
      _changeLanguage(ln ?? 'en');
      return Get.deviceLocale;
    }
    if (lang == 'ar') {
      return const Locale('ar', 'SY');
    } else {
      return const Locale('en', 'US');
    }
  }

  static TextDirection getTextDirection() {
    String lang = getSavedLanguage() ?? "en";
    return lang == 'en' ? TextDirection.ltr : TextDirection.rtl;
  }

  static void _changeLanguage(String code) {
    GetStorage storage = GetStorage();
    storage.write(Constance.languageValue, code);
  }

  static Locale swipeLanguage() {
    GetStorage storage = GetStorage();
    String? lang = storage.read(Constance.languageValue);

    if (lang == null || lang == 'ar') {
      _changeLanguage('en');
      return const Locale('en', 'US');
    }
    _changeLanguage('ar');
    return const Locale('ar', 'SY');
  }

  static void logout() {
    GetStorage storage = GetStorage();
    storage.remove(Constance.loginState);
    storage.remove(Constance.tokenValue);
  }

  static ThemeMode currentTheme() {
    GetStorage storage = GetStorage();
    String current = storage.read(Constance.themeState) ?? 'none';
    switch (current) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}
