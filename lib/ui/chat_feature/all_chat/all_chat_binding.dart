

import 'package:get/get.dart';
import 'package:healthy_minder/ui/chat_feature/all_chat/all_chat_viewmodel.dart';

class AllChatBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AllChatViewmodel());
  }

}