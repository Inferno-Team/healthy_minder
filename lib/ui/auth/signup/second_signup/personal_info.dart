import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/auth/signup/second_signup/personal_info_viewmodel.dart';
import 'package:healthy_minder/ui/custom/custem_button.dart';
import 'package:healthy_minder/ui/custom/custem_text_field.dart';
import 'package:healthy_minder/ui/custom/next_page_indicator.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/translator.dart';

class SecondSignupPage extends GetView<PersonalInfoViewModel> {
  const SecondSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    var groupValue = "Male";
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
                        fontSize: 20, color: Color.fromRGBO(52, 71, 103, 1)),
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
                        label: Keys.birthDate.name.tr,
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
                    label: Keys.weight.name.tr,
                    obscureText: false,
                    textInputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    onChange: (String? value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: CustomTextField(
                    label: Keys.height.name.tr,
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
                        Text(
                          Keys.gender.name.tr,
                          style: const TextStyle(
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
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            Keys.male.name.tr,
                            style: const TextStyle(
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
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            Keys.female.name.tr,
                            style: const TextStyle(
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
                    textbtn: Keys.next.name.tr,
                    onPressed: () {
                      Get.toNamed(HealthyRoutes.finalSignupRoute);
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
