import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/masseage.dart';
import 'package:healthy_minder/ui/chat_feature/chat/chat_viewmodel.dart';
import 'package:healthy_minder/ui/custom/chat_bubble.dart';
import 'package:healthy_minder/ui/custom/custem_circular_btn.dart';
import 'package:healthy_minder/utils/translator.dart';

class ChatScreen extends GetView<ChatViewModel> {
  final _controller = ScrollController();
  final String id = '';
  final String email = '';

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * (0.73 + 0.8),
      child: Column(
        children: [
          Obx(
            () => SizedBox(
              height: size.height * 0.73,
              child: ListView.builder(
                controller: _controller,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                    isMine: controller.messages[index].id == email,
                    message: controller.messages[index],
                    width: size.width * 0.75,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Divider(
                    thickness: 2,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 38,
                        width: size.width * 0.75,
                        child: TextField(
                          controller: controller.textController,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            hintText: Keys.enter.name.tr + Keys.aText.name.tr,
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(251, 99, 64, 1),
                              )
                            ),
                          ),
                        ),
                      ),
                      CustemCircularBtn(
                        containerchild: const Icon(
                          Icons.send_rounded,
                          color: Color.fromRGBO(251, 99, 64, 1),
                        ),
                        onTap: controller.sendNewMessage,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
