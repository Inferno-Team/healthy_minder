import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/disease.dart';
import 'package:healthy_minder/models/goal.dart';
import 'package:healthy_minder/ui/auth/signup/final_signup/final_signup_viewmodel.dart';
import 'package:healthy_minder/ui/custom/custem_button.dart';
import 'package:healthy_minder/ui/custom/next_page_indicator.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class ThirdSignupPage extends GetView<ThirdSignupViewModel> {
  const ThirdSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      fontSize: 20,
                      color: Color.fromRGBO(103, 116, 142, 1),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Do you suffer from any diseases?",
                    style: TextStyle(
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
                    hint: 'select your diseases',
                    options: controller.diseases,
                    selectionType: SelectionType.multi,
                    chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                    dropdownHeight: controller.diseases.length > 6 ? 300 : 200,
                    optionTextStyle:
                        const TextStyle(fontSize: 16, color: Colors.black),
                    selectedOptionIcon: const Icon(Icons.check_circle),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 42),
                  child: Text(
                    "Choose your goal",
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(52, 71, 103, 1)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MultiSelectDropDown<Goal>(
                    onOptionSelected: controller.onGoalSelect,
                    onOptionRemoved: controller.onGoalRemove,
                    hint: 'select your goals',
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
                    textbtn: "Sign Up",
                    onPressed: () {
                      Get.toNamed(HealthyRoutes.homePageRoute);
                    },
                    withIcon: false,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
