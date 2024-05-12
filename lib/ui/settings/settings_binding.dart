import 'package:get/get.dart';

import 'package:healthy_minder/ui/settings/settings_viewmodel.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsViewModel());
  }
}
