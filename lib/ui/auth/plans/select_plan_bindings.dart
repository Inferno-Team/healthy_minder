import 'package:get/get.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/ui/auth/plans/select_plan_viewmodel.dart';

class SelectPlanBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SelectPlanViewmodel(
        dataService: Get.find<DataService>(),
      ),
    );
  }
}
