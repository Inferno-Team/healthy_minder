import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthy_minder/ui/custom/chat_card.dart';
import 'package:healthy_minder/ui/custom/custem_containerborder.dart';
import 'package:healthy_minder/ui/custom/custem_notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustemContainer(
      isDrawerOpen: false,
      child: ListView(
        children: [
          CustemNotificationCard(
              coachname: "Mohmad Ali", notificationdetail: "Add New Meal"),
        ],
      ),
    );
  }
}
