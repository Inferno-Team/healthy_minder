import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/premium_status.dart';
import 'package:healthy_minder/models/return_types.dart';
import 'package:healthy_minder/models/saved_user.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class PremiumViewModel extends GetxController {
  final TextEditingController premiumTextController = TextEditingController();
  final DataService dataService;

  PremiumViewModel({required this.dataService});

  void openCamera() async {
    String? qrCode;
    var request = await Permission.camera.onDeniedCallback(() {
      // Your code
    }).onGrantedCallback(() {
      // Your code
    }).request();
    if (request.isGranted) {
      qrCode = await scanner.scan();
    } else {
      Fluttertoast.showToast(
          msg: "The Camera Permission is needed to scan the QR.");
      return;
    }
  }

  void sendPremiumRequest() async {
    String code = premiumTextController.text;
    Get.back();
    if (code.isEmpty) {
      Fluttertoast.showToast(msg: "code must not be empty");
      return;
    }
    String token = StorageHelper.getToken();
    ReturnType<String?>? response =
        await dataService.sendPremiumRequest(token, code);
    Fluttertoast.showToast(msg: response!.msg.toString());
    ReturnType<PremiumStatus?>? res = await dataService.myPremiumStatus(token);
    if (res is ReturnDataType) {
      PremiumStatus? premiumStatusNullable =
          (res as ReturnDataType<PremiumStatus?>).data;
      Get.find<HomeViewModel>().premiumStatus.value =
          premiumStatusNullable ?? PremiumStatus.empty();
      Get.back(id: 1);
    }
  }
}
