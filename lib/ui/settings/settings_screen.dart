import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/utils/translator.dart';

class SettingsScreen extends StatelessWidget {
  final String userName = '';
  final String email = '';
  final String password = '';
  final String birthdate = '';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool value = false;
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Keys.personalInfo.name.tr,
              style: Get.textTheme.bodyMedium,
            ),
            const Divider(
              thickness: 1.5,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Keys.fullName.name.tr + ":",
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
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Keys.email.name.tr + ":",
                    style: Get.textTheme.bodyMedium,
                  ),
                  Text(
                    email,
                    style: Get.textTheme.bodySmall,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Keys.password.name.tr + ":",
                    style: Get.textTheme.bodyMedium,
                  ),
                  Text(
                    password,
                    style: Get.textTheme.bodySmall,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        size: 21,
                        color: Color.fromRGBO(17, 28, 68, 1),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Keys.birthDate.name.tr + ":",
                    style: Get.textTheme.bodyMedium,
                  ),
                  Text(
                    birthdate,
                    style: Get.textTheme.bodySmall,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Keys.weight.name.tr + ":",
                    style: Get.textTheme.bodyMedium,
                  ),
                  Text(
                    birthdate,
                    style: Get.textTheme.bodySmall,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        size: 21,
                        color: Color.fromRGBO(17, 28, 68, 1),
                      ))
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            Text(
              Keys.general.name.tr,
              style: Get.textTheme.bodyMedium,
            ),
            const Divider(
              thickness: 1.5,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Keys.english.name.tr,
                        style: Get.textTheme.bodyMedium,
                      ),
                      Material(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        child: Switch(
                          value: value,
                          onChanged: (value) {},
                          activeColor: const Color.fromRGBO(67, 216, 147, 1),
                        ),
                      )
                    ])),
            Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Keys.dark.name.tr,
                        style: Get.textTheme.bodyMedium,
                      ),
                      Material(
                        color: Color.fromRGBO(185, 178, 178, 1),
                        child: Switch(
                          value: value,
                          onChanged: (value) {},
                          activeColor: const Color.fromRGBO(67, 216, 147, 1),
                        ),
                      ),
                    ]))
          ],
        ),
      ),
    ]);
  }
}
