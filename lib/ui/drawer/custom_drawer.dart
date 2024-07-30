import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/premium_status.dart';
import 'package:healthy_minder/models/saved_user.dart';
import 'package:healthy_minder/ui/custom/drawer_item.dart';
import 'package:healthy_minder/ui/custom/drawer_top_nav.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';

import 'package:healthy_minder/utils/translator.dart';

class CustomDrawer extends StatelessWidget {
  final SavedUser savedUser;
  final PremiumStatus premiumStatus;
  final void Function(DrawerItem) changeCurrent;
  final void Function() logout;
  final DrawerItem current;

  const CustomDrawer({
    super.key,
    required this.savedUser,
    required this.premiumStatus,
    required this.changeCurrent,
    required this.current,
    required this.logout,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(52, 71, 103, 1),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomDrawerTopNav(
                    username: savedUser.username,
                    email: savedUser.email,
                    avatar: savedUser.avatar,
                    isPremium:
                        premiumStatus.status == PremiumStatusTypes.approved,
                    onSettingPressed: () => changeCurrent(DrawerItem.settings),
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.65,
                child: const Padding(
                  padding: EdgeInsetsDirectional.only(top: 30, start: 10),
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
                            text: Keys.home.name.tr,
                            iconBackground:
                                const Color.fromRGBO(248, 129, 129, 1),
                            iconColor: const Color.fromRGBO(11, 53, 125, 1),
                            isActive: current == DrawerItem.home,
                            onTap: () => changeCurrent(DrawerItem.home),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CustomDrawerItem(
                            icon: FontAwesomeIcons.message,
                            background: Colors.white,
                            text: Keys.publicChat.name.tr,
                            iconBackground:
                                const Color.fromRGBO(157, 64, 251, 1),
                            iconColor: const Color.fromRGBO(255, 255, 255, 1),
                            isActive: current == DrawerItem.message,
                            onTap: () => changeCurrent(DrawerItem.message),
                          ),
                        ),
                        if (premiumStatus.status == PremiumStatusTypes.unknown)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomDrawerItem(
                              icon: FontAwesomeIcons.crown,
                              background: Colors.white,
                              text: Keys.premium.name.tr,
                              iconBackground:
                                  const Color.fromRGBO(60, 125, 146, 1),
                              iconColor: const Color.fromRGBO(255, 214, 0, 1),
                              isActive: current == DrawerItem.premium,
                              onTap: () => changeCurrent(DrawerItem.premium),
                            ),
                          )
                        else if (premiumStatus.status ==
                            PremiumStatusTypes.approved)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomDrawerItem(
                              icon: FontAwesomeIcons.solidMessage,
                              background: Colors.white,
                              text: Keys.chat.name.tr,
                              iconBackground:
                                  const Color.fromRGBO(60, 125, 146, 1),
                              iconColor: const Color.fromRGBO(255, 214, 0, 1),
                              isActive: current == DrawerItem.coachMessage,
                              onTap: () =>
                                  changeCurrent(DrawerItem.coachMessage),
                            ),
                          )
                        else
                          const Padding(
                            padding: EdgeInsets.only(top: 0),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CustomDrawerItem(
                            icon: FontAwesomeIcons.bell,
                            background: Colors.white,
                            text: Keys.notification.name.tr,
                            iconBackground:
                                const Color.fromRGBO(125, 22, 142, 1),
                            iconColor: const Color.fromRGBO(255, 255, 255, 1),
                            isActive: current == DrawerItem.notification,
                            onTap: () => changeCurrent(DrawerItem.notification),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CustomDrawerItem(
                            icon: FontAwesomeIcons.barsProgress,
                            background: Colors.white,
                            text: Keys.myProgress.name.tr,
                            iconBackground:
                                const Color.fromRGBO(22, 142, 110, 1.0),
                            iconColor: const Color.fromRGBO(255, 255, 255, 1),
                            isActive: current == DrawerItem.myProgress,
                            onTap: () => changeCurrent(DrawerItem.myProgress),
                          ),
                        ),
                      ],
                    ),
                    CustomDrawerItem(
                      icon: FontAwesomeIcons.arrowRightFromBracket,
                      background: Colors.white,
                      text: Keys.logOut.name.tr,
                      iconBackground: const Color.fromRGBO(202, 36, 86, 1),
                      iconColor: const Color.fromRGBO(255, 255, 255, 1),
                      isActive: false,
                      isBottom: true,
                      onTap: () => logout(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
