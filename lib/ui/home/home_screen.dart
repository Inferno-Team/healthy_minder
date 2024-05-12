import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/gen/assets.gen.dart';
import 'package:healthy_minder/ui/custom/custem_containerborder.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';
import 'package:healthy_minder/utils/translator.dart';

class HomeScreen extends StatelessWidget {
  final List imgList = [
    Assets.images.img01.path,
    Assets.images.img02.path,
    Assets.images.img03.path,
  ];

  HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 140.0,
                aspectRatio: 16 / 9,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                pauseAutoPlayOnTouch: true,
                enlargeCenterPage: true,
              ),
              items: imgList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: Colors.grey, // Set border color
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.0),
                        child: Image.asset(
                          i,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  Keys.yourGoals.name.tr,
                  style: Get.textTheme.bodyMedium,
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
