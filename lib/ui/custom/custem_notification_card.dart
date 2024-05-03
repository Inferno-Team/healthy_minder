import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:healthy_minder/utils/translator.dart';

class CustemNotificationCard extends StatelessWidget {
  final String coachname;
  final Function()? onTap;
  final String notificationdetail;
  const CustemNotificationCard(
      {super.key,
      required this.coachname,
      this.onTap,
      required this.notificationdetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: InkWell(
              onTap: onTap,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: Get.theme.colorScheme.secondary,
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, top: 14, bottom: 14),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Get.theme
                              .primaryColorLight, // You can set any color you want
                        ),
                        child: Center(
                          child: Text(
                            'M',
                            style: Get.theme.textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 18, left: 8, bottom: 18),
                      child: Column(
                        children: [
                          Text(
                            Keys.coach.name.tr,
                            style: Get.theme.textTheme.bodyLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              notificationdetail,
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
              )),
        ),
      ),
    );
  }
}
