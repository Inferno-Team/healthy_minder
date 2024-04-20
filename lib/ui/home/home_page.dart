import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/custom/custem_circular_btn.dart';
import 'package:healthy_minder/ui/custom/custem_containerborder.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'package:healthy_minder/utils/translator.dart';
import 'package:healthy_minder/utils/constances.dart';

class HomePAge extends GetView<HomeViewModel> {
  const HomePAge({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 99, 64, 1),
      body: ListView(children: [
        SizedBox(
          height: size.height - 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: const Color.fromRGBO(251, 99, 64, 1),
                height: 132,
                child: Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustemCircularBtn(
                              onTap: () {
                                Get.toNamed(HealthyRoutes.welcomeRoute);
                              },
                              containerchild: const Icon(
                                Icons.menu,
                                size: 20,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              Keys.goodMorning.name.tr +
                                  StorageHelper.getUser().username,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: CustemCircularBtn(
                                  onTap: () {
                                    Get.toNamed(HealthyRoutes.welcomeRoute);
                                  },
                                  containerchild: const Icon(
                                    FontAwesomeIcons.bell,
                                    size: 20,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  )))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          Keys.strength.name.tr +
                              Keys.health.name.tr +
                              Keys.andFitness.name.tr,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      )
                    ],
                  )),
                ),
              ),
              const CustemContainer(child: Center())
            ],
          ),
        ),
      ]),
    );
  }
}
