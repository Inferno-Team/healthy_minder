import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class custemtextfield extends StatelessWidget {
  //متغير من اجل الهينت تكست حيث لكل تكست فورم عملنا باني له بارمتر نعطيه قيمة من اجل الهينت

  //متغير من اجل الكونترولر حيث لكل تكست فورم عملنا باني له بارمتر نعطيه قيمة من اجل الكونترولر
  final TextEditingController custencontroller;
  //متغير من اجل التاكد من عملية تعبئة الحقل النصي حيث لكل تكست فورم عملنا باني له بارمتر نعطيه قيمة من اجل التاكد واسندنا خاصية validator go
  final String? Function(String?)? validator;
  final String label;
  // ignore: non_constant_identifier_names
  final Widget? Suffix;
  final bool obScureText;

  const custemtextfield(
      {super.key,
      required this.custencontroller,
      this.validator,
      required this.label,
      this.Suffix,
      required this.obScureText});

  @override
  Widget build(BuildContext context) {
    String obscuringCharacter;
    return Container(
      height: 60,
      child: TextFormField(
        obscureText: obScureText,
        style: TextStyle(fontSize: 15),
        validator: validator,
        controller: custencontroller,
        decoration: InputDecoration(
            label: Text(
              "$label",
              style: TextStyle(
                  fontSize: 15, color: Color.fromRGBO(251, 99, 64, 1)),
            ),
            suffix: Suffix,
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide:
                    const BorderSide(color: Color.fromRGBO(160, 164, 180, 1))),
            filled: true,
            fillColor: const Color.fromRGBO(217, 217, 217, 1)),
      ),
    );
  }
}
