import 'package:get/get.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class WelcomeViewModel extends GetxController {
  final _currentActive = DrawerItem.home.obs;

  DrawerItem get current => _currentActive.value;

  changeCurrent(DrawerItem value) => _currentActive.value = value;
}

enum DrawerItem {
  home,
  message,
  premium,
  notification,
}
