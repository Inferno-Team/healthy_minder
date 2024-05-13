import 'package:get/get.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/ui/auth/signup/signup_viewmodel.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SignupViewmodel(
        dataService: Get.find<DataService>(),
      ),
    );
  }
}
