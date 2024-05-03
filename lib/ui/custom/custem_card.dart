import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/utils/themes.dart';
import 'package:healthy_minder/utils/translator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustemTrainingCard extends StatelessWidget {
  final String progresspercent;
  final double percent;
  final Function()? onTap;
  const CustemTrainingCard(
      {super.key,
      required this.percent,
      required this.progresspercent,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: InkWell(
            onTap: onTap,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              color: const Color.fromRGBO(255, 255, 255, 1),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 20),
                    child: Column(
                      children: [
                        Text(
                          Keys.andFitness.name.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromRGBO(52, 71, 103, 1)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            Keys.coach.name.tr,
                            style: const TextStyle(
                                color: Color.fromRGBO(52, 71, 103, 1)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            Keys.exercies.name.tr + Keys.thisWeek.name.tr,
                            style: const TextStyle(
                                color: Color.fromRGBO(103, 116, 142, 1)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 100, top: 31, right: 8, bottom: 31),
                    child: Center(
                      child: CircularPercentIndicator(
                        center: Text(
                          progresspercent,
                          style: TextStyle(
                              color: lightTheme.textTheme.bodyLarge?.color),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        percent: percent,
                        radius: 64,
                        lineWidth: 10,
                        progressColor: const Color.fromRGBO(67, 217, 131, 1),
                        backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
