import 'package:get/get.dart';
import 'package:healthy_minder/repositories/data_service.dart';

import 'package:healthy_minder/ui/premium/premium_viewmodel.dart';

class PremiumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => PremiumViewModel(
        dataService: Get.find<DataService>(),
      ),
    );
  }
}
