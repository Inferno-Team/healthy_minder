import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomDrawerItem extends StatelessWidget {
  final Color background;
  final String text;
  final Color iconColor;
  final IconData icon;
  final Color iconBackground;
  final bool isActive;
  final bool isBottom;
  final Function()? onTap;

  const CustomDrawerItem({
    super.key,
    required this.background,
    required this.text,
    required this.iconColor,
    required this.icon,
    required this.iconBackground,
    this.isActive = false,
    this.isBottom = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 225,
        margin: isBottom ? const EdgeInsets.only(bottom: 10) : null,
        height: 60,
        decoration: isActive
            ? const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                color: Color.fromRGBO(248, 249, 250, 1),
                boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: Offset(2, 2),
                    ),
                  ])
            : null,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 1),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: iconBackground,
                radius: 21,
                child: Center(
                  child: FaIcon(
                    icon,
                    color: iconColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 9, bottom: 9),
                child: Text(
                  text,
                  style: isActive
                      ? Get.theme.textTheme.bodyMedium
                      : Get.theme.textTheme.titleMedium,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
