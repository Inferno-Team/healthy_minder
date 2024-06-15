import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthy_minder/models/notification.dart';
import 'package:healthy_minder/models/return_types.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class NotificationViewmodel extends GetxController {
  final DataService dataService;
  final _notifications = RxList<Notification>.empty();

  List<Notification> get notifications => _notifications;

  NotificationViewmodel({required this.dataService});

  @override
  void onInit() async {
    String token = StorageHelper.getToken();
    ReturnType<List<Notification>?>? response =
        await dataService.loadMyNotifications(token);
    if (response != null && response is ReturnDataType<List<Notification>?>) {
      _notifications.value = (response).data!;
    }
    super.onInit();
    Get.find<HomeViewModel>().unreadNotifications.listen(
      (p0) {
        _notifications.value = p0;
      },
    );
  }

  sendNotificationSeen(String notId) async {
    String token = StorageHelper.getToken();
    await dataService.sendNotificationSeen(token, notId);
    _notifications.removeWhere((element) => element.id == notId);
    Get.find<HomeViewModel>()
        .unreadNotifications
        .removeWhere((element) => element.id == notId);
  }
}
