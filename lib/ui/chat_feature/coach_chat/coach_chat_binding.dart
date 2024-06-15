import 'package:get/get.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/ui/chat_feature/coach_chat/coach_chat_viewmodel.dart';

class CoachChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CoachChatViewModel(dataService: Get.find<DataService>()));
  }
}
