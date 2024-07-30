import 'package:flutter/material.dart';

class CustemContainer extends StatelessWidget {
  final Widget child;
  final bool isDrawerOpen;
  final TextDirection direction;

  const CustemContainer({
    super.key,
    required this.child,
    required this.isDrawerOpen,
    this.direction = TextDirection.ltr,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: size.height - 150,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(248, 249, 250, 1),
          borderRadius:
          direction == TextDirection.ltr?
          BorderRadius.only(
            topLeft: const Radius.circular(24),
            topRight: const Radius.circular(24),
            bottomLeft: Radius.circular(isDrawerOpen ? 40 : 0),
          ):
          BorderRadius.only(
            topRight: const Radius.circular(24),
            bottomRight: Radius.circular(isDrawerOpen ? 40 : 0),
          )
          ,
        ),
        child: child,
      ),
    );
  }
}
