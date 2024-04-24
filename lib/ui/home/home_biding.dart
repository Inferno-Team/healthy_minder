import 'package:get/get.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeViewModel());

  }
}
