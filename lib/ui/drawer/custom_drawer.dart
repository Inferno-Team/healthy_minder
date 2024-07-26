import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/premium_status.dart';
import 'package:healthy_minder/ui/custom/drawer_item.dart';
import 'package:healthy_minder/ui/custom/drawer_top_nav.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';

import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class CustomDrawer extends GetView<HomeViewModel> {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(52, 71, 103, 1),
      body: Obx(
        () => SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Obx(
                      () => CustomDrawerTopNav(
                        username: controller.savedUser.username,
                        email: controller.savedUser.email,
                        avatar: controller.savedUser.avatar,
                        isPremium: controller.premiumStatus.value.status ==
                            PremiumStatusTypes.approved,
                        onSettingPressed: () =>
                            controller.changeCurrent(DrawerItem.settings),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width * 0.65,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 30, left: 10),
                    child: Divider(
                      thickness: 1,
                      color: Color.fromRGBO(248, 249, 250, 1),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: CustomDrawerItem(
                              icon: FontAwesomeIcons.house,
                              background: Colors.white,
                              text: "Home",
                              iconBackground:
                                  const Color.fromRGBO(248, 129, 129, 1),
                              iconColor: const Color.fromRGBO(11, 53, 125, 1),
                              isActive: controller.current == DrawerItem.home,
                              onTap: () =>
                                  controller.changeCurrent(DrawerItem.home),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomDrawerItem(
                              icon: FontAwesomeIcons.message,
                              background: Colors.white,
                              text: "Public Chat",
                              iconBackground:
                                  const Color.fromRGBO(157, 64, 251, 1),
                              iconColor: const Color.fromRGBO(255, 255, 255, 1),
                              isActive:
                                  controller.current == DrawerItem.message,
                              onTap: () =>
                                  controller.changeCurrent(DrawerItem.message),
                            ),
                          ),
                          Obx(() {
                            if (controller.premiumStatus.value.status ==
                                PremiumStatusTypes.unknown) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: CustomDrawerItem(
                                  icon: FontAwesomeIcons.crown,
                                  background: Colors.white,
                                  text: "Premium",
                                  iconBackground:
                                      const Color.fromRGBO(60, 125, 146, 1),
                                  iconColor:
                                      const Color.fromRGBO(255, 214, 0, 1),
                                  isActive:
                                      controller.current == DrawerItem.premium,
                                  onTap: () => controller
                                      .changeCurrent(DrawerItem.premium),
                                ),
                              );
                            } else if (controller.premiumStatus.value.status ==
                                PremiumStatusTypes.approved) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: CustomDrawerItem(
                                  icon: FontAwesomeIcons.solidMessage,
                                  background: Colors.white,
                                  text: "Coach Chat",
                                  iconBackground:
                                      const Color.fromRGBO(60, 125, 146, 1),
                                  iconColor:
                                      const Color.fromRGBO(255, 214, 0, 1),
                                  isActive: controller.current ==
                                      DrawerItem.coachMessage,
                                  onTap: () => controller
                                      .changeCurrent(DrawerItem.coachMessage),
                                ),
                              );
                            } else {
                              return const Padding(
                                padding: EdgeInsets.only(top: 0),
                              );
                            }
                          }),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomDrawerItem(
                              icon: FontAwesomeIcons.bell,
                              background: Colors.white,
                              text: "Notification",
                              iconBackground:
                                  const Color.fromRGBO(125, 22, 142, 1),
                              iconColor: const Color.fromRGBO(255, 255, 255, 1),
                              isActive:
                                  controller.current == DrawerItem.notification,
                              onTap: () => controller
                                  .changeCurrent(DrawerItem.notification),
                            ),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomDrawerItem(
                              icon: FontAwesomeIcons.barsProgress,
                              background: Colors.white,
                              text: "My Progress",
                              iconBackground:
                                  const Color.fromRGBO(22, 142, 110, 1.0),
                              iconColor: const Color.fromRGBO(255, 255, 255, 1),
                              isActive:
                                  controller.current == DrawerItem.myProgress,
                              onTap: () => controller
                                  .changeCurrent(DrawerItem.myProgress),
                            ),
                          ),

                        ],
                      ),
                      CustomDrawerItem(
                        icon: FontAwesomeIcons.arrowRightFromBracket,
                        background: Colors.white,
                        text: "LogOut",
                        iconBackground: const Color.fromRGBO(202, 36, 86, 1),
                        iconColor: const Color.fromRGBO(255, 255, 255, 1),
                        isActive: false,
                        isBottom: true,
                        onTap: controller.logout,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
