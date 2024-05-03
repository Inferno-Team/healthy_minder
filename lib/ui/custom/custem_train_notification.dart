import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/utils/translator.dart';

class CustemTrainCard extends StatelessWidget {
  const CustemTrainCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: Get.theme.colorScheme.secondary,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 14, bottom: 14),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Get.theme
                          .primaryColorLight, // You can set any color you want
                    ),
                    child: Center(
                      child: Icon(
                        Icons.alarm,
                        color: Get.theme.colorScheme.secondary,
                        size: 36,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18, left: 8, bottom: 18),
                  child: Column(
                    children: [
                      Text(
                        Keys.alarm.name.tr,
                        style: Get.theme.textTheme.bodyLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          Keys.its.name.tr +
                              Keys.time.name.tr +
                              Keys.to.name.tr +
                              Keys.train.name.tr,
                          style: Get.theme.textTheme.displaySmall,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "3${Keys.min.name.tr}${Keys.ago.name.tr}",
                    style: Get.theme.textTheme.displaySmall,
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
