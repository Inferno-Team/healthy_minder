import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/chat_feature/all_chat/all_chat_viewmodel.dart';
import 'package:healthy_minder/ui/custom/chat_card.dart';
import 'package:healthy_minder/ui/custom/custem_containerborder.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/translator.dart';

class AllChatScreen extends GetView<AllChatViewmodel> {
  const AllChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustemContainer(
        isDrawerOpen: false,
        child: Center(
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(251, 99, 64, 1),
        onPressed: controller.gotoNewChat,
        child: const Icon(
          Icons.add,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }


}
