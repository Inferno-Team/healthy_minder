import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactCard extends StatelessWidget {
  //contact card is used in new chat screen
  final String username;
  final void Function()? onTap;
  const ContactCard({super.key, this.onTap, required this.username});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        width: size.width,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(),
              Text(
                username,
                style: Get.textTheme.bodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
