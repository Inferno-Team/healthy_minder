import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/disease.dart';
import 'package:healthy_minder/models/goal.dart';
import 'package:healthy_minder/ui/auth/signup/thirt_signup/final_signup_viewmodel.dart';
import 'package:healthy_minder/ui/custom/custem_button.dart';
import 'package:healthy_minder/ui/custom/next_page_indicator.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/translator.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class ThirtSignupPage extends GetView<ThirtSignupViewModel> {
  const ThirtSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var disese = "desiese";
    var goal = "Fitness";
    return Scaffold(
        backgroundColor: const Color.fromRGBO(248, 249, 250, 1),
        body: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height - 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      Keys.personalInfo.name.tr,
                      style: const TextStyle(
                          fontSize: 48,
                          color: Color.fromRGBO(52, 71, 103, 1),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      Keys.personalInfoTitle.name.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(103, 116, 142, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      Keys.diseaseQuestion.name.tr,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(52, 71, 103, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: MultiSelectDropDown<Disease>(
                      onOptionSelected: controller.onDiseaseSelect,
                      onOptionRemoved: controller.onDiseaseRemove,
                      hint: Keys.selectYourDiseases.name.tr,
                      options: controller.diseases,
                      selectionType: SelectionType.multi,
                      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                      dropdownHeight:
                          controller.diseases.length > 6 ? 300 : 200,
                      optionTextStyle:
                          const TextStyle(fontSize: 16, color: Colors.black),
                      selectedOptionIcon: const Icon(Icons.check_circle),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 42),
                    child: Text(
                      Keys.goalsQuestion.name.tr,
                      style: const TextStyle(
                          fontSize: 15, color: Color.fromRGBO(52, 71, 103, 1)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: MultiSelectDropDown<Goal>(
                      onOptionSelected: controller.onGoalSelect,
                      onOptionRemoved: controller.onGoalRemove,
                      hint: Keys.goalsQuestion.name.tr,
                      options: controller.goals,
                      selectionType: SelectionType.multi,
                      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                      dropdownHeight: controller.goals.length > 6 ? 300 : 200,
                      optionTextStyle:
                          const TextStyle(fontSize: 16, color: Colors.black),
                      selectedOptionIcon: const Icon(Icons.check_circle),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.25),
                    child: const NextPageIndicator(current: 3),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: custemBtn(
                      textbtn: Keys.signup.name.tr,
                      onPressed: () {
                        Get.toNamed(HealthyRoutes.HomePageRoute);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
