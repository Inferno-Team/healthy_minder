import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/custom/custem_circular_btn.dart';
import 'package:healthy_minder/ui/custom/custem_containerborder.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'package:healthy_minder/utils/translator.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends GetView<HomeViewModel> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List imglist = [
      Image.asset('images/img01.jpg'),
      Image.asset('images/img01.jpg'),
      Image.asset('images/img01.jpg'),
    ];
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
                                  fontWeight: FontWeight.bold,
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
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      )
                    ],
                  )),
                ),
              ),
              CustemContainer(
                  child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                  child: Column(
                    children: [
                      CarouselSlider(
                          options: CarouselOptions(
                            height: 150.0,
                            aspectRatio: 16 / 9,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            pauseAutoPlayOnTouch: true,
                            enlargeCenterPage: true,
                          ),
                          items: imglist.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: Colors.grey, // Set border color
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(''),
                                  ),
                                );
                              },
                            );
                          }).toList())
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ]),
    );
  }
}
