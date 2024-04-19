import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/auth/login/login_viewmodel.dart';
import 'package:healthy_minder/ui/custom/custem_button.dart';
import 'package:healthy_minder/ui/custom/custem_text_field.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/translator.dart';

class LoginPage extends GetView<LoginViewmodel> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 249, 250, 1),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text(
                  Keys.login.name.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                    color: Color.fromRGBO(52, 71, 103, 1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                Keys.loginTitle.name.tr,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(103, 116, 142, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CustomTextField(
                  label: Keys.email.name.tr,
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                  onChange: (String? value) {}),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Obx(
                () => CustomTextField(
                  label: Keys.password.name.tr,
                  obscureText: controller.passwordState,
                  onChange: (String? value) {},
                  suffix: IconButton(
                    onPressed: controller.changePasswordState,
                    icon:  FaIcon(
                      controller.passwordState?
                      FontAwesomeIcons.eye:
                      FontAwesomeIcons.eyeSlash,
                      color:const Color.fromRGBO(251, 99, 64, 1),
                      size: 18,
                    ),
                  ),
                  textInputType: TextInputType.text,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 50),
                  child: Row(
                    children: [
                      Text(
                        Keys.doNotHaveAccount.name.tr,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(103, 116, 142, 1),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(HealthyRoutes.firstSignupRoute);
                        },
                        child: Text(
                          Keys.registerNow.name.tr,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(52, 71, 103, 1),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: custemBtn(
                textbtn: Keys.login.name.tr,
                onPressed: () {
                  Get.toNamed(HealthyRoutes.homePageRoute);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
