import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.ProgressIndicator});
final Widget ProgressIndicator;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ProgressIndicator,
    );
  }
}