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
    storage.write(Constance.loginState, true);
    storage.write(Constance.tokenValue, token);
  }

  static saveUser(SavedUser user) =>
      storage.write(Constance.savedUser, user.toJson());

  static saveOtherData(String otherData) =>
      storage.write(Constance.otherValues, otherData);

  static String getOtherData() => storage.read(Constance.otherValues) ?? "{}";

  static saveCurrentStep(String step) =>
      storage.write(Constance.currentStep, step);

  static bool isLoggedIn() => storage.read(Constance.loginState) ?? false;

  static String getToken() => storage.read(Constance.tokenValue) ?? "";

  static SavedUser getUser() {
    var data = storage.read(Constance.savedUser);
    if (data != null) {
      return SavedUser.fromJson(data);
    }
    return SavedUser.empty();
  }

  static String? getSavedLanguage() => storage.read(Constance.languageValue);

  static void registerLanguageCallback(void Function(dynamic value) callback){
     storage.listenKey(Constance.languageValue,callback);
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

  static _changeLanguage(String code) =>
      storage.write(Constance.languageValue, code);

  static Locale swipeLanguage() {
    String? lang = storage.read(Constance.languageValue);

    if (lang == null || lang == 'ar') {
      _changeLanguage('en');
      return const Locale('en', 'US');
    }
    _changeLanguage('ar');
    return const Locale('ar', 'SY');
  }

  static void logout() => storage.erase();

  static ThemeMode currentTheme() {
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

  static String getCurrentStep() => storage.read(Constance.currentStep) ?? "";

  static void saveTheme(ThemeMode mode) {
    storage.write(Constance.themeState, mode.name);
  }
}
