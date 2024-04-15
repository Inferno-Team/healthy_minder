import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/auth/signup/signup_viewmodel.dart';
import 'package:healthy_minder/ui/custom/custem_button.dart';
import 'package:healthy_minder/ui/custom/custem_text_field.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class signUpPage extends GetView<signupViewModel> {
  const signUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController Email = TextEditingController();
    TextEditingController fullName = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassWord = TextEditingController();

    return Scaffold(
        backgroundColor: const Color.fromRGBO(248, 249, 250, 1),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 48,
                        color: Color.fromRGBO(52, 71, 103, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Sign up to start ",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(103, 116, 142, 1)),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: custemtextfield(
                        custencontroller: Email,
                        label: "Email",
                        obScureText: false)),
                Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: custemtextfield(
                        custencontroller: fullName,
                        label: "Full Name",
                        obScureText: false)),
                Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: custemtextfield(
                      custencontroller: password,
                      label: "PassWord",
                      obScureText: true,
                      Suffix: IconButton(
                          onPressed: () {
                            obScureText:
                            false;
                          },
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Color.fromRGBO(251, 99, 64, 1),
                          )),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: custemtextfield(
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
                        custencontroller: confirmPassWord,
                        label: "Confirm PassWord",
                        obScureText: true)),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 75),
                      child: Row(
                        children: [
                          const Text(
                            "Already have accounr? ",
                            style: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(103, 116, 142, 1)),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(HealthyRoutes.oldUserPasswordRoute);
                            },
                            child: const Text(
                              "Login",
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
                  padding: const EdgeInsets.only(top: 80, left: 80),
                  child: Row(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(251, 99, 64, 1)),
                            color: const Color.fromRGBO(217, 217, 217, 1),
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                            child: Text(
                          "1",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(52, 71, 103, 1)),
                        )),
                      ),
                      const Text(
                        "-------",
                        style: TextStyle(color: Color.fromRGBO(251, 99, 64, 1)),
                      ),
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(251, 99, 64, 0.4)),
                            color: const Color.fromRGBO(217, 217, 217, 0.4),
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                            child: Text(
                          "2",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(52, 71, 103, 0.4)),
                        )),
                      ),
                      const Text(
                        "-------",
                        style: TextStyle(color: Color.fromRGBO(251, 99, 64, 1)),
                      ),
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(251, 99, 64, 0.4)),
                            color: const Color.fromRGBO(217, 217, 217, 0.4),
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                            child: Text(
                          "3",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(52, 71, 103, 0.4)),
                        )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: custemBtn(
                    textbtn: "Log In",
                    onPressed: () {
                      Get.toNamed(HealthyRoutes.homePageRoute);
                    },
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
