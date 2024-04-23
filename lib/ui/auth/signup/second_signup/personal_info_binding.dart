import 'package:get/get.dart';
import 'package:healthy_minder/ui/auth/signup/second_signup/personal_info_viewmodel.dart';

class PersonalInfoBinding extends Bindings  {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalInfoViewModel());
  }
}
