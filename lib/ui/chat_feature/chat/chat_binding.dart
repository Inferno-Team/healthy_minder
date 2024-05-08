import 'package:get/get.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/ui/chat_feature/chat/chat_viewmodel.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatViewModel(dataService: Get.find<DataService>()));
  }
}
