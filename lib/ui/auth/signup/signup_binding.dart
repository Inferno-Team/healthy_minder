import 'package:get/get.dart';
import 'package:healthy_minder/ui/auth/signup/signup_viewmodel.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => signupViewModel());
  }
}
