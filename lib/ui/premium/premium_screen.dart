import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:healthy_minder/ui/custom/custem_button.dart';
import 'package:healthy_minder/ui/custom/custem_containerborder.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';
import 'package:healthy_minder/ui/premium/premium_viewmodel.dart';
import 'package:healthy_minder/utils/translator.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeViewModel>(
      init: Get.find<HomeViewModel>(),
      builder: (HomeViewModel controller) {
        return CustemContainer(
          isDrawerOpen: controller.isDrawerOpen,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    height: 75,
                    width: 190,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(17, 28, 68, 1),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24))),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "25K SP",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(251, 99, 64, 1)),
                          ),
                          Text(
                            Keys.onceAndForAll.name.tr,
                            style: Get.textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Keys.access.name.tr +
                              Keys.toAll.name.tr +
                              Keys.features.name.tr,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(52, 71, 103, 1)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 46),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(52, 71, 103, 1),
                              borderRadius: BorderRadius.circular(25)),
                          child: const Center(
                            child: Text(
                              "1",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            ),
                          ),
                        ),
                        Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(67, 216, 147, 1),
                              borderRadius: BorderRadius.circular(28)),
                          child: const Center(
                            child: Icon(
                              Icons.check_rounded,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ),
                        Text(
                          Keys.chat.name.tr +
                              Keys.withAny.name.tr +
                              Keys.coach.name.tr,
                          style: Get.textTheme.bodyMedium,
                        )
                      ],
                    ),
                  ),
                  VerticalDivider(
                    thickness: 2,
                    color: Color.fromRGBO(160, 164, 180, 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(52, 71, 103, 1),
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                          child: Text(
                            "2",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(255, 255, 255, 1)),
                          ),
                        ),
                      ),
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(67, 216, 147, 1),
                            borderRadius: BorderRadius.circular(28)),
                        child: const Center(
                          child: Icon(
                            Icons.check_rounded,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ),
                      Text(
                        Keys.choose.name.tr +
                            Keys.your.name.tr +
                            Keys.private.name.tr +
                            Keys.coach.name.tr,
                        style: Get.textTheme.bodyMedium,
                      )
                    ],
                  ),
                  VerticalDivider(
                    thickness: 2,
                    color: Color.fromRGBO(160, 164, 180, 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(52, 71, 103, 1),
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                          child: Text(
                            "3",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(255, 255, 255, 1)),
                          ),
                        ),
                      ),
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(67, 216, 147, 1),
                            borderRadius: BorderRadius.circular(28)),
                        child: const Center(
                          child: Icon(
                            Icons.check_rounded,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ),
                      Text(
                        Keys.change.name.tr +
                            Keys.your.name.tr +
                            Keys.coach.name.tr,
                        style: Get.textTheme.bodyMedium,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Text(
                      Keys.content.name.tr,
                      style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(185, 180, 180, 1)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 75),
                    child: custemBtn(
                      textbtn: Keys.upgrade.name.tr + Keys.toPremium.name.tr,
                      onPressed: () {},
                      withIcon: true,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
