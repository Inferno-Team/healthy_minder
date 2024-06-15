import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/custom/custem_notification_card.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';
import 'package:healthy_minder/ui/notifications/notification_viewmodel.dart';
import 'package:healthy_minder/models/notification.dart' as not;

class NotificationScreen extends GetView<NotificationViewmodel> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * (0.73 + 0.8),
      child: Obx(
        () => SizedBox(
          height: size.height * (0.73 + 0.8),
          child: ListView.builder(
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              not.Notification notification = controller.notifications[index];
              DateTime createdAt = DateTime.fromMillisecondsSinceEpoch(
                notification.timestamp,
              );
              return CustomNotificationCard(
                title: notification.title,
                body: notification.body,
                timestamp: _createTimeStamp(createdAt),
                notId: notification.id,
                avatar: notification.avatar,
                onTap: controller.sendNotificationSeen,
              );
            },
          ),
        ),
      ),
    );
  }

  String _createTimeStamp(DateTime createdAt) {
    DateTime now = DateTime.now();
    if (now.difference(createdAt).inHours > 24) {
      return "${createdAt.year}-${_fixDate(createdAt.month)}-${_fixDate(createdAt.day)}";
    } else {
      return _createTimeStampForSameDay(createdAt);
    }
  }

  String _fixDate(int date) => date <= 9 ? "0$date" : "$date";

  String _createTimeStampForSameDay(DateTime createdAt) =>
      "${_fixDate(createdAt.hour)}:${_fixDate(createdAt.minute)}:${_fixDate(createdAt.second)}";
}
