import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/utils/translator.dart';

class CustemTrainingCard extends StatelessWidget {
  const CustemTrainingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), // Set circular border radius
        ),
        color: Color.fromRGBO(255, 255, 255, 1),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 20),
              child: Column(
                children: [
                  Text(
                    Keys.andFitness.name.tr,
                    style: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(52, 71, 103, 1)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
