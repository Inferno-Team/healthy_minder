import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/profile.dart';
import 'package:healthy_minder/models/return_types.dart';
import 'package:healthy_minder/models/saved_user.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SettingsViewModel extends GetxController {
  final DataService dataService;

  SettingsViewModel({required this.dataService});

  final _themeStatus = false.obs;
  final _englishStatus = false.obs;
  final _profile = Profile.empty().obs;

  Profile get profile => _profile.value;

  void changeTheme(bool value) => _themeStatus.value = value;

  void changeLanguage(bool value) => _englishStatus.value = value;

  bool get themeModeValue => _themeStatus.value;

  bool get englishStatus => _englishStatus.value;

  @override
  void onInit() async {
    _themeStatus.value = StorageHelper.currentTheme() == ThemeMode.dark;
    _englishStatus.value = StorageHelper.getSavedLanguage() == 'en';
    _themeStatus.listen((currentTheme) {
      ThemeMode mode = currentTheme ? ThemeMode.dark : ThemeMode.light;
      StorageHelper.saveTheme(mode);
      Get.changeThemeMode(mode);
    });
    _englishStatus.listen((currentLang) {
      Locale locale = StorageHelper.swipeLanguage();
      Get.locale = locale;
    });
    ReturnType<Profile?>? returnType =
        await dataService.getProfile(StorageHelper.getToken());
    if (returnType != null) {
      if (returnType is ReturnError) {
        List<Error>? errors = (returnType as ReturnError).errors;
        Fluttertoast.showToast(msg: errors.first.error);
      } else if (returnType is ReturnDataType) {
        Profile? profile = (returnType as ReturnDataType).data;
        if (profile != null) {
          _profile.value = profile;
        }
      }
    }
    super.onInit();
  }

  Future<void> onImageClicked() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      try {
        // Use compute to run the compression in a separate isolate
        File compressedFile = File(image.path);
        print(compressedFile.path);
        // final File compressedFile = await compressImage(file);
        String avatarPath = compressedFile.path;
        // print("Original File size : ${await file.length()}");
        print("Compressed File size : ${await compressedFile.length()}");
        profile.avatar = avatarPath;
        _profile.value = Profile.fromJson(profile.toJson());
        // send this image to backend as this user profile avatar.
        String token = StorageHelper.getToken();
        ReturnType<SavedUser?>? response =
            await dataService.updateProfileAvatar(token, compressedFile);
        if (response != null) {
          if (response is ReturnDataType<SavedUser?>) {
            SavedUser user = response.data!;
            StorageHelper.saveUser(user);
          }
        }
      } catch (e) {
        print('Image compression failed: $e');
      }
    }
  }

  // Future<File> compressImage(File file) async {
  //   final imageBytes = await file.readAsBytes();
  //
  //   final compressedBytes = await FlutterImageCompress.compressWithList(
  //     imageBytes,
  //     minWidth: 800,
  //     minHeight: 600,
  //     quality: 85,
  //   );
  //   String extension = file.path.split('.').last;
  //   // Create a new file to save the compressed image
  //   String newPath = file.path.replaceAll(
  //     RegExp(r'\.\w+$'), // Regex to replace the extension
  //     '_compressed.$extension',
  //   );
  //   File compressedFile = File(newPath);
  //   // Write the compressed image data to the new file
  //   await compressedFile.writeAsBytes(compressedBytes);
  //   return compressedFile;
  // }
}
