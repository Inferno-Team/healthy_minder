import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CustomDrawerTopNav extends StatelessWidget {
  final String username;
  final String email;

  final void Function() onSettingPressed;

  const CustomDrawerTopNav({
    super.key,
    this.username = "",
    this.email = "",
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
          CircleAvatar(
            radius: 32,
            backgroundColor: const Color.fromRGBO(86, 185, 117, 1),
            child: Center(
              child: Text(
                username.characters.length > 1 ? username.characters.first : '',
                style: Get.textTheme.bodyLarge,
              ),
            ),
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
