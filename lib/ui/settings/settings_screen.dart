import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/settings/settings_viewmodel.dart';
import 'package:healthy_minder/utils/translator.dart';

class SettingsScreen extends GetView<SettingsViewModel> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
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
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => GestureDetector(
                          onTap: controller.onImageClicked,
                          child: CircleAvatar(
                            radius: 64,
                            backgroundColor:
                                const Color.fromRGBO(86, 185, 117, 1),
                            child: controller.profile.avatar == null
                                ? Center(
                                    child: Text(
                                      controller.profile.userName.characters
                                                  .length >
                                              1
                                          ? controller
                                              .profile.userName.characters.first
                                              .toUpperCase()
                                          : '',
                                      style: Get.textTheme.bodyMedium,
                                    ),
                                  )
                                : ClipOval(
                                    child: !controller.profile.avatar!
                                            .startsWith("http")
                                        ? Image.file(
                                            File(controller.profile.avatar!),
                                            fit: BoxFit.cover,
                                            width: 128,
                                            height: 128,
                                          )
                                        : Image.network(
                                            controller.profile.avatar!,
                                            fit: BoxFit.cover,
                                            width: 128,
                                            height: 128,
                                          ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${Keys.firstName.name.tr}: ",
                        style: Get.textTheme.bodyMedium,
                      ),
                      Text(
                        controller.profile.firstName,
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
                        "${Keys.lastName.name.tr}: ",
                        style: Get.textTheme.bodyMedium,
                      ),
                      Text(
                        controller.profile.lastName,
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
                        "${Keys.userName.name.tr}: ",
                        style: Get.textTheme.bodyMedium,
                      ),
                      Text(
                        controller.profile.userName,
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
                        "${Keys.email.name.tr}: ",
                        style: Get.textTheme.bodyMedium,
                      ),
                      Text(
                        controller.profile.email,
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
                        "${Keys.birthDate.name.tr}: ",
                        style: Get.textTheme.bodyMedium,
                      ),
                      Text(
                        controller.profile.dob,
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
                        "${Keys.weight.name.tr}: ",
                        style: Get.textTheme.bodyMedium,
                      ),
                      Text(
                        "${controller.profile.weight} Kg",
                        style: Get.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${Keys.height.name.tr}: ",
                        style: Get.textTheme.bodyMedium,
                      ),
                      Text(
                        "${controller.profile.height} cm",
                        style: Get.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 50)),
                Text(
                  Keys.timeline.name.tr,
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
                        "${Keys.coach.name.tr}: ",
                        style: Get.textTheme.bodyMedium,
                      ),
                      Text(
                        controller.profile.coach,
                        style: Get.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${Keys.timeline.name.tr} Name : ",
                        style: Get.textTheme.bodyMedium,
                      ),
                      Text(
                        controller.profile.timelineName,
                        style: Get.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Events Count : ",
                        style: Get.textTheme.bodyMedium,
                      ),
                      Text(
                        "${controller.profile.eventCount}",
                        style: Get.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
