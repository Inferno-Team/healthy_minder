import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthy_minder/models/saved_user.dart';
import 'package:healthy_minder/utils/constances.dart';

class StorageHelper {
  static late GetStorage storage;

  static Future<void> init() async {
    await GetStorage.init();
    storage = GetStorage();
  }

  static void login(String token) {
    storage = GetStorage();
    storage.write(Constance.loginState, true);
    storage.write(Constance.tokenValue, token);
  }

  static void saveUser(SavedUser user) {
    storage = GetStorage();
    storage.write(Constance.savedUser, user.toJson());
  }

  static bool isLoggedIn() {
    storage = GetStorage();
    return storage.read(Constance.loginState) ?? false;
  }

  static String getToken() {
    storage = GetStorage();
    return storage.read(Constance.tokenValue) ?? "";
  }

  static SavedUser getUser() {
    storage = GetStorage();
    var data = storage.read(Constance.savedUser);
    if (data != null) {
      return SavedUser.fromJson(data);
    }
    return SavedUser.empty();
  }

  static String? getSavedLanguage() {
    storage = GetStorage();
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
    storage = GetStorage();
    storage.write(Constance.languageValue, code);
  }

  static Locale swipeLanguage() {
    storage = GetStorage();
    String? lang = storage.read(Constance.languageValue);

    if (lang == null || lang == 'ar') {
      _changeLanguage('en');
      return const Locale('en', 'US');
    }
    _changeLanguage('ar');
    return const Locale('ar', 'SY');
  }

  static void logout() {
    storage = GetStorage();
    storage.remove(Constance.loginState);
    storage.remove(Constance.tokenValue);
    storage.remove(Constance.savedUser);
  }

  static ThemeMode currentTheme() {
    storage = GetStorage();
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

  static void saveTheme(ThemeMode mode) {
    storage = GetStorage();
    storage.write(Constance.themeState, mode.name);
  }
}
