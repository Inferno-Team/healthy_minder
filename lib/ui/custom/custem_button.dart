import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/loading_status.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool withIcon;
  final String text;
  final IconData? icon;
  final Color? iconColor;
  final LoadingStatus status;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.withIcon,
    this.status = LoadingStatus.succeeded,
    this.icon,
    this.iconColor,
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
      child: [
        LoadingStatus.loading,
        LoadingStatus.started,
      ].contains(status)
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Row(
              mainAxisAlignment: withIcon
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.center,
              children: [
                Text(
                  (text),
                  style: Get.textTheme.headlineMedium,
                ),
                withIcon
                    ? Icon(icon,color: iconColor,)
                    : Container()
              ],
            ),
    );
  }
}
