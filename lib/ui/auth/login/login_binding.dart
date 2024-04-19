import 'package:get/get.dart';
import 'package:healthy_minder/ui/auth/login/login_viewmodel.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginViewmodel());
  }
}
