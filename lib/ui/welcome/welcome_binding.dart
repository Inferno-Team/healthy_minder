import 'package:get/get.dart';
import 'package:healthy_minder/ui/welcome/welcome_viewmodel.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeViewModel());
  }
}
