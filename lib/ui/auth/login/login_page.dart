import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/auth/login/login_viewmodel.dart';
import 'package:healthy_minder/ui/custom/custem_button.dart';
import 'package:healthy_minder/ui/custom/custem_text_field.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class loginPage extends GetView<loginViewmodel> {
  const loginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController UserNameEmail = TextEditingController();
    TextEditingController PassWord = TextEditingController();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 249, 250, 1),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 48,
                        color: Color.fromRGBO(52, 71, 103, 1)),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  "Log in to your account",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromRGBO(103, 116, 142, 1)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: custemtextfield(
                  custencontroller: UserNameEmail,
                  label: 'UserName or Email',
                  obScureText: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: custemtextfield(
                  custencontroller: PassWord,
                  label: 'PassWord',
                  obScureText: true,
                  Suffix: IconButton(
                    onPressed: () {
                      obScureText:
                      false;
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Color.fromRGBO(251, 99, 64, 1),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 50),
                    child: Row(
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(103, 116, 142, 1)),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(HealthyRoutes.newUserPageRoute);
                          },
                          child: const Text(
                            "Register now",
                            style: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(52, 71, 103, 1),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: custemBtn(
                  textbtn: "Log In",
                  onPressed: () {
                    Get.toNamed(HealthyRoutes.homePageRoute);
                  },
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
