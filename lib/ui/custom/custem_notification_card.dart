import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomNotificationCard extends StatelessWidget {
  final String title;
  final void Function(String notId) onTap;
  final String body;
  final String timestamp;
  final String? avatar;
  final String notId;

  const CustomNotificationCard({
    super.key,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.onTap,
    this.avatar,
    required this.notId,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: InkWell(
            onTap: () => onTap(notId),
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
                    child: avatar != null
                        ? ClipOval(
                            child: Image.network(
                              avatar!,
                              fit: BoxFit.cover,
                              width: 48,
                              height: 48,
                            ),
                          )
                        : const SizedBox(
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
                        SizedBox(
                          width: size.width * 0.4,
                          child: Text(
                            title,
                            style: Get.theme.textTheme.bodyLarge,
                            softWrap: true,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              body,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Get.theme.textTheme.displaySmall,
                            ),
                          ),
                        ),
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
