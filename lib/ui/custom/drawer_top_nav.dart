import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomDrawerTopNav extends StatelessWidget {
  final String username;
  final String email;
  final String? avatar;
  final bool isPremium;
  final void Function() onSettingPressed;

  const CustomDrawerTopNav({
    super.key,
    this.username = "",
    this.email = "",
    this.avatar,
    this.isPremium = false,
    required this.onSettingPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 65, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              if (isPremium)
                const FaIcon(
                  FontAwesomeIcons.crown,
                  color: Colors.yellowAccent,
                ),
              CircleAvatar(
                radius: 64,
                backgroundColor: const Color.fromRGBO(86, 185, 117, 1),
                child: avatar == null
                    ? Center(
                        child: Text(
                          username.characters.length > 1
                              ? username.characters.first.toUpperCase()
                              : '',
                          style: Get.textTheme.bodyMedium,
                        ),
                      )
                    : ClipOval(
                        child: !avatar!.startsWith("http")
                            ? Image.file(
                                File(avatar!),
                                fit: BoxFit.cover,
                                width: 128,
                                height: 128,
                              )
                            : Image.network(
                                avatar!,
                                fit: BoxFit.cover,
                                width: 128,
                                height: 128,
                              ),
                      ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.37,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    username,
                    style: Get.textTheme.displayMedium,
                    softWrap: true,
                    maxLines: 2,
                  ),
                ),
              ),
              IconButton(
                // onPressed: () {},
                onPressed: onSettingPressed,
                icon: const Icon(
                  Icons.settings,
                  size: 20,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              email,
              style: Get.textTheme.headlineSmall,
            ),
          )
        ],
      ),
    );
  }
}
