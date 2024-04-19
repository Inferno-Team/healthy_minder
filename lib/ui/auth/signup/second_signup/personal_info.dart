import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/auth/signup/second_signup/personal_info_viewmodel.dart';
import 'package:healthy_minder/ui/custom/custem_button.dart';
import 'package:healthy_minder/ui/custom/custem_text_field.dart';
import 'package:healthy_minder/ui/custom/next_page_indicator.dart';
import 'package:healthy_minder/utils/constances.dart';

class SecondSignupPage extends GetView<PersonalInfoViewModel> {
  const SecondSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    var groupValue = "Meal";
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
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: GetBuilder<PersonalInfoViewModel>(
                    init: Get.find<PersonalInfoViewModel>(),
                    global: false,
                    id: "dob-widget",
                    builder: (PersonalInfoViewModel controller) {
                      return CustomTextField(
                        label: "Birth Date",
                        textInputType: TextInputType.none,
                        onTap: () => controller.showDatePickerWidget(context),
                        textController: controller.dobTextController,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: CustomTextField(
                    label: "Weight",
                    obscureText: false,
                    textInputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onChange: (String? value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: CustomTextField(
                    label: "Height",
                    obscureText: false,
                    textInputType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChange: (String? value) {},
                  ),
                ),
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
                            color: Color(0xff344767),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Obx(
                            () => Radio(
                              fillColor: const MaterialStatePropertyAll(
                                Color.fromRGBO(251, 99, 64, 1),
                              ),
                              activeColor: const Color.fromRGBO(251, 99, 64, 1),
                              value: "Male",
                              groupValue: controller.gender,
                              onChanged: (object) =>
                                  controller.changeGender('Male'),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "Male",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(251, 99, 64, 1),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Obx(
                            () => Radio(
                              fillColor: const MaterialStatePropertyAll(
                                Color.fromRGBO(251, 99, 64, 1),
                              ),
                              activeColor: const Color.fromRGBO(251, 99, 64, 1),
                              value: "Female",
                              groupValue: controller.gender,
                              onChanged: (object) =>
                                  controller.changeGender('Female'),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "Female",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(251, 99, 64, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.25),
                  child: const NextPageIndicator(current: 2),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: custemBtn(
                    textbtn: "Next",
                    onPressed: () {
                      Get.toNamed(HealthyRoutes.thirtSignupRoute);
                    },
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
