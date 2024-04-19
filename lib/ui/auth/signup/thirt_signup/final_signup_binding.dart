import 'package:get/get.dart';
import 'package:healthy_minder/ui/auth/signup/thirt_signup/final_signup_viewmodel.dart';

class ThirdSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThirtSignupViewModel());
  }
}
