import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomNotificationCard extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final String body;
  final String timestamp;

  const CustomNotificationCard({
    super.key,
    required this.title,
    required this.body,
    required this.timestamp,
    this.onTap,
  });

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
                    const Padding(
                      padding: EdgeInsets.only(left: 12, top: 14, bottom: 14),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: Icon(Icons.message),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 18, left: 8, bottom: 18),
                      child: Column(
                        children: [
                          Text(
                            title,
                            style: Get.theme.textTheme.bodyLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              body,
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
                        timestamp,
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
