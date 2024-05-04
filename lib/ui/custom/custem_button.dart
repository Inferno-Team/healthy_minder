import 'package:flutter/material.dart';

class custemBtn extends StatelessWidget {
  final void Function()? onPressed;
  final bool withIcon;
  final String textbtn;
  const custemBtn({
    super.key,
    this.onPressed,
    required this.textbtn,
    required this.withIcon,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
      height: 60,
      minWidth: 360,
      color: const Color.fromRGBO(251, 99, 64, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment:
            withIcon ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
        children: [
          Text(
            (textbtn),
            style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1), fontSize: 20),
          ),
          withIcon ? const Icon(Icons.qr_code_scanner_rounded) : Container()
        ],
      ),
    );
  }
}
