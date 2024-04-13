import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawerTopNav extends StatelessWidget {
  final String username;
  final String email;

  const CustomDrawerTopNav({
    super.key,
    this.username = "",
    this.email = "",
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
          SizedBox(
            width: size.width * 0.45,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                username,
                style: Get.textTheme.displayLarge,
                softWrap: true,
                maxLines: 2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              email,
              style: Get.textTheme.displaySmall,
            ),
          )
        ],
      ),
    );
  }
}
