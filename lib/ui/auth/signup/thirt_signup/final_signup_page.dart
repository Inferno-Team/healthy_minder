import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:healthy_minder/ui/auth/signup/thirt_signup/final_signup_viewmodel.dart';
import 'package:healthy_minder/ui/custom/custem_button.dart';
import 'package:healthy_minder/utils/constances.dart';

class ThirtSignupPage extends GetView<ThirtSignupViewModel> {
  const ThirtSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var disese = "desiese";
    var goal = "Fitness";
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
                    "Personal Info",
                    style: TextStyle(
                        fontSize: 48,
                        color: Color.fromRGBO(52, 71, 103, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Before start We would love to have your help ",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(103, 116, 142, 1)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Do you suffer from any diseases?",
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(52, 71, 103, 1)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: DropdownButton(
                    hint: Text(
                      "Select",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(103, 116, 142, 1)),
                    ),
                    isDense: true,
                    dropdownColor: Color.fromRGBO(255, 255, 255, 1),
                    focusColor: Color.fromRGBO(55, 55, 55, 1),
                    isExpanded: true,
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(103, 116, 142, 1),
                        fontWeight: FontWeight.bold),
                    items: ["desiese", "Curestrol", "Diabetes"]
                        .map((e) => DropdownMenuItem(
                              child: Text("$e"),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {},
                    value: disese,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 42),
                  child: Text(
                    "Choose your goal",
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(52, 71, 103, 1)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: DropdownButton(
                    hint: Text(
                      "Select",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(103, 116, 142, 1)),
                    ),
                    isDense: true,
                    dropdownColor: Color.fromRGBO(255, 255, 255, 1),
                    focusColor: Color.fromRGBO(55, 55, 55, 1),
                    isExpanded: true,
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(103, 116, 142, 1),
                        fontWeight: FontWeight.bold),
                    items: ["Fitness", "body building", "Cardio"]
                        .map((e) => DropdownMenuItem(
                              child: Text("$e"),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {},
                    value: goal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 240, left: 80),
                  child: Row(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(251, 99, 64, 1)),
                            color: const Color.fromRGBO(251, 99, 64, 1),
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                            child: Text(
                          "1",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(255, 255, 255, 1)),
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
                                color: const Color.fromRGBO(251, 99, 64, 1)),
                            color: const Color.fromRGBO(251, 99, 64, 1),
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                            child: Text(
                          "2",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(255, 255, 255, 1)),
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
                                color: const Color.fromRGBO(251, 99, 64, 1)),
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                            child: Text(
                          "3",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(251, 99, 64, 1)),
                        )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: custemBtn(
                    textbtn: "Sign Up",
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
