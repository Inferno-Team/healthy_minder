import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/auth/signup/first_signup/signup_viewmodel.dart';
import 'package:healthy_minder/ui/custom/custem_button.dart';
import 'package:healthy_minder/ui/custom/custem_text_field.dart';
import 'package:healthy_minder/ui/custom/next_page_indicator.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/translator.dart';

class SignUpPage extends GetView<SignupViewModel> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 249, 250, 1),
      // resizeToAvoidBottomInset: false,
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
                    Keys.signup.name.tr,
                    style: const TextStyle(
                        fontSize: 48,
                        color: Color.fromRGBO(52, 71, 103, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    Keys.signupTitle.name.tr,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(103, 116, 142, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: CustomTextField(
                    label: Keys.firstName.name.tr,
                    textInputType: TextInputType.name,
                    onChange: (String? value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: CustomTextField(
                    label: Keys.lastName.name.tr,
                    textInputType: TextInputType.name,
                    onChange: (String? value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CustomTextField(
                    label: Keys.email.name.tr,
                    textInputType: TextInputType.emailAddress,
                    onChange: (String? value) {},
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CustomTextField(
                      label: Keys.password.name.tr,
                      obscureText: true,
                      suffix: IconButton(
                        onPressed: controller.changePasswordState,
                        icon: FaIcon(
                          controller.passwordState
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: const Color.fromRGBO(251, 99, 64, 1),
                          size: 18,
                        ),
                      ),
                      textInputType: TextInputType.text,
                      onChange: (String? value) {},
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 75),
                    child: Row(
                      children: [
                        Text(
                          Keys.alreadyHaveAccount.name.tr,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color.fromRGBO(103, 116, 142, 1),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(HealthyRoutes.loginRoute);
                          },
                          child: Text(
                            Keys.login.name.tr,
                            style: const TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(52, 71, 103, 1),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.25),
                  child: const NextPageIndicator(current: 1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: custemBtn(
                    textbtn: Keys.next.name.tr,
                    onPressed: () {
                      Get.toNamed(HealthyRoutes.secondSignupRoute);
                    },
                    withIcon: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
