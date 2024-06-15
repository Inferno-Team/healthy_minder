import 'package:get/get.dart';
import 'package:healthy_minder/utils/constances.dart';

class AllChatViewmodel extends GetxController {
  void gotoNewChat() {
    Get.toNamed(HealthyRoutes.newMessageRoute, id: 1);
  }
}
