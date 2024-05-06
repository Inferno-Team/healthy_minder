import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/custom/chat_bubble.dart';
import 'package:healthy_minder/ui/custom/custem_circular_btn.dart';
import 'package:healthy_minder/utils/translator.dart';

class ChatScreen extends StatelessWidget {
  final _controller = ScrollController();
  final String id = '';
  final String email = '';

  List masseageList = [];
  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          ListView.builder(
              reverse: true,
              controller: _controller,
              itemCount: masseageList.length,
              itemBuilder: (context, index) {
                return masseageList[index].id == email
                    ? ChatBuble(
                        message: masseageList[index],
                      )
                    : ChatBubleForFriend(message: masseageList[index]);
              }),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const Divider(
                  thickness: 2,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
                const Padding(padding: EdgeInsets.only(top: 8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextField(
                      controller: textController,
                      onSubmitted: (data) {
                        textController.clear();
                        _controller.animateTo(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.bounceIn);
                      },
                      decoration: InputDecoration(
                        hintText: Keys.enter.name.tr + Keys.aText.name.tr,
                      ),
                    ),
                    CustemCircularBtn(
                      containerchild: const Icon(
                        Icons.send_rounded,
                        color: Color.fromRGBO(251, 99, 64, 1),
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
