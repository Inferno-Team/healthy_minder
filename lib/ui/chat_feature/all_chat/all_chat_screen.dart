import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/custom/chat_card.dart';
import 'package:healthy_minder/utils/translator.dart';

class AllChatScreen extends StatelessWidget {
  const AllChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Keys.thereIs.name.tr +
                    Keys.noChatYet.name.tr +
                    "\n" +
                    Keys.pressOn.name.tr +
                    Keys.plusIcon.name.tr +
                    Keys.toStart.name.tr +
                    Keys.neweChat.name.tr,
                style: Get.textTheme.titleMedium,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(251, 99, 64, 1),
          onPressed: () {},
          tooltip: 'Increment',
          child: const Icon(
            Icons.add,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ));
  }
}
