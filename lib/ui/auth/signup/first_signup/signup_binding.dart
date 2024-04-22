import 'package:get/get.dart';
import 'package:healthy_minder/ui/auth/signup/first_signup/signup_viewmodel.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupViewModel());
  }
}