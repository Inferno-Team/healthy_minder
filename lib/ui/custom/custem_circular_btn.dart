import 'package:flutter/material.dart';

class CustemCircularBtn extends StatelessWidget {
  final Widget containerchild;
  final void Function()? onTap;
  const CustemCircularBtn(
      {super.key, required this.containerchild, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
            color: Color.fromRGBO(217, 217, 217, 0.25),
            borderRadius: BorderRadius.circular(32)),
        child: Center(child: containerchild),
      ),
    );
  }
}
