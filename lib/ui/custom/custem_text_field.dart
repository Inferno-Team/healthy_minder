import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  //متغير من اجل الهينت تكست حيث لكل تكست فورم عملنا باني له بارمتر نعطيه قيمة من اجل الهينت

  //متغير من اجل التاكد من عملية تعبئة الحقل النصي حيث لكل تكست فورم عملنا باني له بارمتر نعطيه قيمة من اجل التاكد واسندنا خاصية validator go
  final String? Function(String?)? validator;
  final void Function(String? value)? onChange;
  final String label;
  final dynamic textInputType;

  final Widget? suffix;

  final bool obscureText;
  final void Function()? onTap;

  final String? value;

  final TextEditingController? textController;

  const CustomTextField({
    super.key,
    this.validator,
    required this.label,
    this.onChange,
    this.suffix,
    this.obscureText = false,
    required this.textInputType,
    this.onTap,
    this.value,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        onTap: onTap,
        onTapAlwaysCalled: true,
        keyboardType: textInputType,
        obscureText: obscureText,
        onChanged: onChange,
        initialValue: value,
        controller: textController,
        style: const TextStyle(fontSize: 15, color: Colors.black),
        validator: validator,
        decoration: InputDecoration(
          label: Text(
            label,
            style: Get.textTheme.titleSmall
          ),
          suffixIcon: suffix,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              color: Color.fromRGBO(160, 164, 180, 1),
            ),
          ),
          filled: true,
          fillColor: const Color.fromRGBO(217, 217, 217, 1),
        ),
      ),
    );
  }
}
