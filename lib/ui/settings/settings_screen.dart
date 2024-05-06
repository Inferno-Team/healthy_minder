import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/utils/translator.dart';

class SettingsScreen extends StatelessWidget {
  final String userName = '';
  final String email = '';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 54),
        child: Column(
          children: [
            Text(
              Keys.personalInfo.name.tr,
              style: Get.textTheme.bodySmall,
            ),
            Divider(
              thickness: 1.5,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    Keys.fullName.name.tr,
                    style: Get.textTheme.bodyMedium,
                  ),
                  Text(
                    userName,
                    style: Get.textTheme.bodySmall,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    Keys.email.name.tr,
                    style: Get.textTheme.bodyMedium,
                  ),
                  Text(
                    email,
                    style: Get.textTheme.bodySmall,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
