import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/welcome/welcome_viewmodel.dart';

class WelcomePage extends GetView<WelcomeViewModel> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(52, 71, 103, 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 65, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Color.fromRGBO(86, 185, 117, 1),
                    child: Center(
                      child: Text(
                        "M",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Color.fromRGBO(213, 245, 238, 1)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "MoustafaZeno",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color.fromRGBO(5, 17, 57, 1)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "www.moustafa998@gmail.com",
                      style: TextStyle(
                          fontSize: 10,
                          color: Color.fromRGBO(103, 116, 142, 1)),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Divider(
                thickness: 1,
                color: Color.fromRGBO(248, 249, 250, 1),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: InkWell(
                child: Container(
                  width: 225,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                      color: Color.fromRGBO(248, 249, 250, 1),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: Offset(2, 2))
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromRGBO(248, 129, 129, 1),
                          child: Center(
                              child: Icon(
                            Icons.home_filled,
                            color: Color.fromRGBO(11, 53, 125, 1),
                          )),
                          radius: 21,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, top: 9, bottom: 9),
                          child: Text(
                            "Home",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(52, 71, 103, 1)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(left: 30, top: 20),
                child: Row(children: [
                  CircleAvatar(
                    radius: 21,
                    backgroundColor: Color.fromRGBO(157, 64, 251, 1),
                    child: Center(
                      child: Icon(
                        Icons.message_rounded,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 9, bottom: 9),
                    child: Text(
                      "Messages",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromRGBO(160, 164, 180, 1)),
                    ),
                  )
                ]),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(left: 30, top: 20),
                child: Row(children: [
                  CircleAvatar(
                    radius: 21,
                    backgroundColor: Color.fromRGBO(60, 125, 146, 1),
                    child: Center(
                      child: Icon(
                        Icons.workspace_premium_outlined,
                        color: Color.fromRGBO(255, 214, 0, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 9, bottom: 9),
                    child: Text(
                      "Premium",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromRGBO(160, 164, 180, 1)),
                    ),
                  )
                ]),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(left: 30, top: 20),
                child: Row(children: [
                  CircleAvatar(
                    radius: 21,
                    backgroundColor: Color.fromRGBO(125, 22, 142, 1),
                    child: Center(
                      child: Icon(
                        Icons.notifications_none_outlined,
                        color: Color.fromRGBO(255, 111, 119, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 9, bottom: 9),
                    child: Text(
                      "Notification",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromRGBO(160, 164, 180, 1)),
                    ),
                  )
                ]),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 150)),
            InkWell(
              child: Padding(
                padding: EdgeInsets.only(left: 30, top: 1),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromRGBO(202, 36, 86, 1),
                      radius: 21,
                      child: Center(
                        child: Icon(
                          Icons.logout,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, top: 9, bottom: 9),
                      child: Text(
                        "LogOut",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromRGBO(160, 164, 180, 1)),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {},
            )
          ],
        ));
  }
}
