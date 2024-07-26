import 'package:flutter/material.dart';

class CustomCircularButton extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final bool disabled;

  const CustomCircularButton({
    super.key,
    required this.child,
    this.onTap,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(217, 217, 217, 0.25),
            borderRadius: BorderRadius.circular(40)),
        child: Center(child: child),
      ),
    );
  }
}
