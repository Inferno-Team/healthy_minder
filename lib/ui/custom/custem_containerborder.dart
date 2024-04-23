import 'package:flutter/material.dart';
import 'package:healthy_minder/utils/themes.dart';

class CustemContainer extends StatelessWidget {
  final Widget child;

  const CustemContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: size.height - 150,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(248, 249, 250, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomLeft: Radius.circular(40),
          ),
        ),
        child: child,
      ),
    );
  }
}
