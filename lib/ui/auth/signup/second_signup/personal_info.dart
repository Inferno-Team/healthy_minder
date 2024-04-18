import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/auth/signup/second_signup/personal_info_viewmodel.dart';
import 'package:healthy_minder/ui/custom/custem_button.dart';
import 'package:healthy_minder/ui/custom/custem_text_field.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class SecondSignupPage extends GetView<PersonalInfoViewModel> {
  const SecondSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    var groupValue;
    Size size = MediaQuery.of(context).size;
    TextEditingController BirthDate = TextEditingController();
    TextEditingController fullName = TextEditingController();
    TextEditingController Weight = TextEditingController();
    TextEditingController Height = TextEditingController();

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
                    padding: const EdgeInsets.only(top: 32),
                    child: custemtextfield(
                      custencontroller: fullName,
                      label: "Full Name",
                      obScureText: false,
                      TextInputType: TextInputType.name,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: custemtextfield(
                      custencontroller: BirthDate,
                      label: "Birth Date",
                      obScureText: false,
                      TextInputType: TextInputType.datetime,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: custemtextfield(
                      custencontroller: Weight,
                      label: "Weight",
                      obScureText: false,
                      TextInputType: TextInputType.number,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: custemtextfield(
                      custencontroller: Height,
                      label: "Height",
                      obScureText: false,
                      TextInputType: TextInputType.number,
                    )),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 32, left: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Gender:",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(251, 99, 64, 1)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Radio(
                              fillColor: MaterialStatePropertyAll(
                                  Color.fromRGBO(251, 99, 64, 1)),
                              activeColor: Color.fromRGBO(251, 99, 64, 1),
                              value: "Male",
                              groupValue: groupValue,
                              onChanged: (Object? value) {},
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "Male",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(251, 99, 64, 1)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Radio(
                              fillColor: MaterialStatePropertyAll(
                                  Color.fromRGBO(251, 99, 64, 1)),
                              activeColor: Color.fromRGBO(251, 99, 64, 1),
                              value: "Female",
                              groupValue: groupValue,
                              onChanged: (Object? value) {},
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "Female",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(251, 99, 64, 1)),
                            ),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 80),
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
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                            child: Text(
                          "2",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(251, 99, 64, 1)),
                        )),
                      ),
                      const Text(
                        "-------",
                        style:
                            TextStyle(color: Color.fromRGBO(217, 217, 217, 1)),
                      ),
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(217, 217, 217, 1)),
                            color: const Color.fromRGBO(217, 217, 217, 0.4),
                            borderRadius: BorderRadius.circular(25)),
                        child: const Center(
                            child: Text(
                          "3",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(52, 71, 103, 0.5)),
                        )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: custemBtn(
                    textbtn: "Next",
                    onPressed: () {
                      Get.toNamed(HealthyRoutes.thirtSignupRoute);
                    },
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
