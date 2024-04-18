import 'package:flutter/material.dart';

class custemBtn extends StatelessWidget {
  final void Function()? onPressed;
  final String textbtn;
  const custemBtn({super.key, this.onPressed, required this.textbtn});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
      height: 60,
      minWidth: 360,
      color: Color.fromRGBO(251, 99, 64, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      onPressed: onPressed,
      child: Text(
        ("$textbtn"),
        style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: 20),
      ),
    );
  }
}
