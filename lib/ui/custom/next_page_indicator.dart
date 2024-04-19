import 'package:flutter/material.dart';

class NextPageIndicator extends StatelessWidget {
  final int current;

  const NextPageIndicator({
    super.key,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.4,
      child: Row(
        children: [
          IndicatorItem(
            value: 1,
            isCurrent: 1 == current,
            hasBefore: 1 < current,
          ),
          IndicatorSeparator(
            isBefore: 1 < current,
          ),
          IndicatorItem(
            value: 2,
            isCurrent: 2 == current,
            hasBefore: 2 < current,
          ),
          IndicatorSeparator(
            isBefore: 2 < current,
          ),
          IndicatorItem(
            value: 3,
            isCurrent: 3 == current,
            hasBefore: 3 < current,
          )
        ],
      ),
    );
  }
}

class IndicatorSeparator extends StatelessWidget {
  final bool isBefore;

  const IndicatorSeparator({
    super.key,
    required this.isBefore,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "-------",
      style: TextStyle(
        color: isBefore
            ? const Color.fromRGBO(251, 99, 64, 1)
            : const Color.fromRGBO(217, 217, 217, 1),
      ),
    );
  }
}

class IndicatorItem extends StatelessWidget {
  final int value;
  final bool isCurrent;
  final bool hasBefore;

  const IndicatorItem({
    super.key,
    required this.value,
    required this.isCurrent,
    required this.hasBefore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        border: Border.all(
          color: isCurrent
              ? const Color.fromRGBO(251, 99, 64, 1)
              : const Color.fromRGBO(217, 217, 217, 1),
        ),
        color: hasBefore
            ? const Color.fromRGBO(251, 99, 64, 1)
            : isCurrent
                ? const Color.fromRGBO(255, 255, 255, 1)
                : const Color.fromRGBO(217, 217, 217, 0.4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          "$value",
          style: TextStyle(
            fontSize: 12,
            color: hasBefore
                ? const Color.fromRGBO(255, 255, 255, 1)
                : isCurrent
                    ? const Color.fromRGBO(251, 99, 64, 1)
                    : const Color.fromRGBO(52, 71, 103, 0.5),
          ),
        ),
      ),
    );
  }
}
