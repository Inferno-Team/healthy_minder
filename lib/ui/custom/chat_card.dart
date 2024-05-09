import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ChatCard extends StatelessWidget {
  //chat card is used in all chat screen
  final String username;
  final String massegae;
  final String date;
  final void Function()? onTap;
  const ChatCard(
      {super.key,
      required this.username,
      this.onTap,
      required this.massegae,
      required this.date});

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
              Container(width: 48, height: 48, child: CircleAvatar()),
              Column(
                children: [
                  Text(
                    username,
                    style: Get.textTheme.bodyMedium,
                  ),
                  Text(
                    massegae,
                    style: Get.textTheme.bodySmall,
                  )
                ],
              ),
              Text(
                date,
                style: TextStyle(
                    fontSize: 12, color: Color.fromRGBO(217, 217, 217, 0.6)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
