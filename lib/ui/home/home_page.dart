import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/custom/custem_circular_btn.dart';
import 'package:healthy_minder/ui/custom/custem_containerborder.dart';
import 'package:healthy_minder/ui/drawer/custom_drawer.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'package:healthy_minder/utils/translator.dart';
import 'package:healthy_minder/utils/constances.dart';

class HomePage extends GetView<HomeViewModel> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      onPopInvoked: controller.onBackPressed,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(251, 99, 64, 1),
        body: Obx(
          () => Stack(
            children: [
              Directionality(
                textDirection: controller.direction,
                child: CustomDrawer(
                  changeCurrent: controller.changeCurrent,
                  current: controller.current,
                  logout: controller.logout,
                  premiumStatus: controller.premiumStatus.value,
                  savedUser: controller.savedUser,
                ),
              ),
              AnimatedContainer(
                transform: Matrix4.translationValues(
                  controller.xOffset,
                  controller.yOffset,
                  0,
                )
                  ..scale(controller.isDrawerOpen ? 0.80 : 1.00)
                  ..rotateZ(controller.rotateZValue),
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: controller.isDrawerOpen
                      ? BorderRadius.circular(40)
                      : BorderRadius.circular(0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      offset: Offset(controller.xShadowOffset, 0),
                    )
                  ],
                ),
                child: Directionality(
                  textDirection: controller.direction,
                  child: SingleChildScrollView(
                    // physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          height: size.height,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(251, 99, 64, 1),
                            borderRadius: controller.isDrawerOpen
                                ? BorderRadius.circular(40)
                                : BorderRadius.circular(0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => CustomHomeTopBar(
                                  isDrawerOpen: controller.isDrawerOpen,
                                  toggleMenu: controller.toggleMenu,
                                  message: controller.message,
                                  openNotification: controller.openNotification,
                                  notificationCount:
                                      controller.unreadNotifications.length,
                                  direction: controller.direction,
                                ),
                              ),
                              CustemContainer(
                                isDrawerOpen: controller.isDrawerOpen,
                                direction: controller.direction,
                                child: Navigator(
                                  key: Get.nestedKey(1),
                                  initialRoute: HealthyRoutes.homeScreenRoute,
                                  onGenerateRoute: controller.onGenerateRoute,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomHomeTopBar extends StatelessWidget {
  final bool isDrawerOpen;
  final String message;
  final int notificationCount;
  final void Function()? toggleMenu;
  final void Function()? openNotification;
  final TextDirection direction;

  const CustomHomeTopBar({
    super.key,
    required this.isDrawerOpen,
    required this.openNotification,
    this.toggleMenu,
    required this.message,
    required this.notificationCount,
    this.direction = TextDirection.ltr,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(251, 99, 64, 1),
        borderRadius: isDrawerOpen
            ? direction == TextDirection.ltr
                ? const BorderRadius.only(
                    topLeft: Radius.circular(40),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(40),
                  )
            : const BorderRadius.only(
                topLeft: Radius.circular(0),
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomCircularButton(
                      onTap: toggleMenu,
                      child: Icon(
                        isDrawerOpen
                            ? direction == TextDirection.ltr
                                ? Icons.arrow_forward_ios
                                : Icons.arrow_back_ios
                            : Icons.menu,
                        size: 28,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SizedBox(
                        width: size.width * 0.6,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          "${Keys.hello.name.tr} ${StorageHelper.getUser().username}",
                          style: Get.textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Stack(
                        children: [
                          CustomCircularButton(
                            onTap: openNotification,
                            child: const Icon(
                              FontAwesomeIcons.bell,
                              size: 20,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            height: 50,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                child: Text("$notificationCount"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                    Keys.strength.name.tr +
                        Keys.health.name.tr +
                        Keys.andFitness.name.tr,
                    style: Get.textTheme.headlineMedium),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: message != ''
                    ? Text(
                        message,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      )
                    : Container(
                        height: 21,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
