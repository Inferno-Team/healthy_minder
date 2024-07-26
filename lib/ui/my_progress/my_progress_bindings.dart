import 'package:get/get.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/ui/my_progress/my_progress_viewmodel.dart';

class MyProgressBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MyProgressViewModel(
        dataService: Get.find<DataService>(),
      ),
    );
  }
}
