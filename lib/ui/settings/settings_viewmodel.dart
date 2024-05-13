import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class SettingsViewModel extends GetxController {
  final _themeStatus = false.obs;
  void changeTheme(bool value) => _themeStatus.value = value;
  bool get themeModeValue => _themeStatus.value;
  @override
  void onInit() async {
    _themeStatus.value = StorageHelper.currentTheme() == ThemeMode.dark;
    _themeStatus.listen((currentTheme) {
      ThemeMode mode = currentTheme ? ThemeMode.dark : ThemeMode.light;
      StorageHelper.saveTheme(mode);
      Get.changeThemeMode(mode);
    });
    super.onInit();
  }
}
