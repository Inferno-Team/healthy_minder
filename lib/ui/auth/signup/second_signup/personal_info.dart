import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/auth/signup/signup_viewmodel.dart';
import 'package:healthy_minder/ui/custom/custem_button.dart';
import 'package:healthy_minder/ui/custom/custem_text_field.dart';
import 'package:healthy_minder/ui/custom/next_page_indicator.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/translator.dart';

class SecondSignupPage extends GetView<SignupViewmodel> {
  const SecondSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(
      () => Scaffold(
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
                    child: Text(Keys.personalInfo.name.tr,
                        style: Get.textTheme.titleLarge),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      Keys.personalInfoTitle.name.tr,
                      style: Get.textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: CustomTextField(
                      label: Keys.birthDate.name.tr,
                      textInputType: TextInputType.none,
                      onTap: () => controller.showDatePickerWidget(context),
                      textController: controller.dobTextController,
                      errorLabel: controller.birthDateError,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: CustomTextField(
                      label: Keys.weight.name.tr,
                      obscureText: false,
                      textInputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onChange: controller.weightChanged,
                      textInputAction: TextInputAction.next,
                      onTap: controller.clearWeightValidation,
                      errorLabel: controller.weightError,
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
                      onChange: controller.heightChanged,
                      onTap: controller.clearHeightValidation,
                      errorLabel: controller.heightError,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32, left: 20),
                      child: Row(
                        children: [
                          Text(Keys.gender.name.tr,
                              style: Get.textTheme.bodyMedium),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Obx(
                              () => Radio(
                                fillColor: const MaterialStatePropertyAll(
                                  Color.fromRGBO(251, 99, 64, 1),
                                ),
                                activeColor:
                                    const Color.fromRGBO(251, 99, 64, 1),
                                value: "Male",
                                groupValue: controller.gender,
                                onChanged: (object) =>
                                    controller.changeGender('Male'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(Keys.male.name.tr,
                                style: Get.textTheme.titleSmall),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Obx(
                              () => Radio(
                                fillColor: const MaterialStatePropertyAll(
                                  Color.fromRGBO(251, 99, 64, 1),
                                ),
                                activeColor:
                                    const Color.fromRGBO(251, 99, 64, 1),
                                value: "Female",
                                groupValue: controller.gender,
                                onChanged: (object) =>
                                    controller.changeGender('Female'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(Keys.female.name.tr,
                                style: Get.textTheme.titleSmall),
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
                    child: CustomButton(
                      text: Keys.next.name.tr,
                      onPressed: controller.validateSecondPage,
                      withIcon: false,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
