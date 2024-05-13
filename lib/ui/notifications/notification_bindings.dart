import 'package:get/get.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/ui/notifications/notification_viewmodel.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => NotificationViewmodel(
        dataService: Get.find<DataService>(),
      ),
    );
  }
}
