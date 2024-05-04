import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class PremiumViewModel extends GetxController {
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
}
