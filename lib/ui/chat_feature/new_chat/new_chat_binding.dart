import 'package:get/get.dart';
import 'package:healthy_minder/ui/chat_feature/new_chat/new_chat_viewmodel.dart';

class NewChatBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewChatViewmodel());
  }
}
