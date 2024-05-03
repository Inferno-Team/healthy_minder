import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/custom/custem_circular_btn.dart';
import 'package:healthy_minder/ui/custom/custem_containerborder.dart';
import 'package:healthy_minder/ui/drawer/custom_drawer.dart';
import 'package:healthy_minder/ui/premium/premium_viewmodel.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'package:healthy_minder/utils/translator.dart';
import 'package:healthy_minder/utils/constances.dart';

class PremiumPage extends GetView<PremiumViewModel> {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      onPopInvoked: controller.onBackPressed,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(251, 99, 64, 1),
        body: Stack(
          children: [
            CustomDrawer(),
            Obx(
              () => AnimatedContainer(
                transform: Matrix4.translationValues(
                  controller.xOffset,
                  controller.yOffset,
                  0,
                )
                  ..scale(controller.isDrawerOpen ? 0.80 : 1.00)
                  ..rotateZ(controller.isDrawerOpen ? -50 : 0.00),
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
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
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
                            CustomHomeTopBar(
                              isDrawerOpen: controller.isDrawerOpen,
                              toggleMenu: controller.toggleMenu,
                            ),
                            SizedBox(
                              height: size.height - 150,
                              child: Navigator(
                                key: Get.nestedKey(1),
                                initialRoute: HealthyRoutes.premiumScreenRoute,
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
    );
  }
}

class CustomHomeTopBar extends StatelessWidget {
  final bool isDrawerOpen;
  final void Function()? toggleMenu;

  const CustomHomeTopBar({
    super.key,
    required this.isDrawerOpen,
    this.toggleMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(251, 99, 64, 1),
        borderRadius: isDrawerOpen
            ? const BorderRadius.only(
                topLeft: Radius.circular(40),
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
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustemCircularBtn(
                      onTap: toggleMenu,
                      containerchild: Icon(
                        isDrawerOpen ? Icons.arrow_forward_ios : Icons.menu,
                        size: 20,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                    Text(
                      Keys.premium.name.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                width: 95,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(17, 28, 68, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Center(
                  child: Text(
                    Keys.ksp.name.tr,
                    style: const TextStyle(
                        fontSize: 32, color: Color.fromRGBO(251, 99, 64, 1)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
