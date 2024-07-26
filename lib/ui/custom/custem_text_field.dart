import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function(String? value)? onChange;
  final String label;
  final dynamic textInputType;
  final String? errorLabel;

  final Widget? suffix;

  final bool obscureText;
  final void Function()? onTap;

  final String? value;

  final TextEditingController? textController;
  final TextInputAction textInputAction;

  const CustomTextField(
      {super.key,
      this.validator,
      required this.label,
      this.onChange,
      this.suffix,
      this.obscureText = false,
      required this.textInputType,
      this.onTap,
      this.value,
      this.textController,
      this.textInputAction = TextInputAction.done,
      this.errorLabel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: errorLabel == null?60:80,
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
        textInputAction: textInputAction,
        decoration: InputDecoration(
          label: Text(label, style: Get.textTheme.titleSmall),
          suffixIcon: suffix,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              color: Color.fromRGBO(160, 164, 180, 0.75),
            ),
          ),
          filled: true,
          fillColor: const Color.fromRGBO(217, 217, 217, 1),
          errorText: errorLabel,
          errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2
            ),
          ),
        ),
      ),
    );
  }
}
