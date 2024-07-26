import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_corner_banner/flutter_corner_banner.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/timeline_event.dart';
import 'package:healthy_minder/ui/custom/custom_banner.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    super.key,
    required this.event,
  });

  final TimelineEvent event;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color.fromRGBO(251, 99, 64, 0.2),
        ),
        child: CustomCornerBanner(
          bannerText: event.itemType,
          bannerColor: const Color.fromRGBO(251, 99, 64, 0.75),
          bannerPosition: BannerPosition.topRight,
          bannerSize: 60,
          showBanner: true,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: event.itemType == 'Meal'
                ? CustomEventMeal(
                    event: event.eventItem as MealEventItem,
                    eventStartAt: event.eventStartAt,
                    eventEndAt: event.eventEndAt,
                    progress: event.progress,
                  )
                : CustomEventExercise(
                    event: event.eventItem as ExerciseEventItem,
                    eventStartAt: event.eventStartAt,
                    eventEndAt: event.eventEndAt,
                    progress: event.progress,
                  ),
          ),
        ),
      ),
    );
  }
}

class CustomEventMeal extends StatelessWidget {
  final MealEventItem event;
  final DateTime eventStartAt;
  final DateTime eventEndAt;
  final int progress;

  const CustomEventMeal(
      {super.key,
      required this.event,
      required this.eventStartAt,
      required this.eventEndAt,
      required this.progress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showInfoDialog,
      child: Column(
        children: [
          Row(
            children: [
              const Text("Name : "),
              CustomEventText(text: event.name),
            ],
          ),
          Row(
            children: [
              const Text("Type : "),
              CustomEventText(text: event.type),
            ],
          ),
          Row(
            children: [
              const Text("Quantity : "),
              CustomEventText(text: event.qty),
            ],
          ),
          Row(
            children: [
              const Text("Quantity Type : "),
              CustomEventText(text: event.qtyType),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularPercentIndicator(
                radius: 20.0,
                lineWidth: 5.0,
                percent: (progress / 100),
                center: progress != 100
                    ? Text(
                        "$progress%",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      )
                    : const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                progressColor:
                    progress != 100 ? Get.theme.primaryColor : Colors.green,
              ),
              CustomEventDateWidget(
                  eventStartAt: eventStartAt, eventEndAt: eventEndAt),
            ],
          ),
        ],
      ),
    );
  }

  void _showInfoDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text(event.name, style: Get.textTheme.displaySmall),
        content: SizedBox(
          height: 500,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ingredients : "),
                      Divider(
                        thickness: 1.5,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ],
                  ),
                ),
                Text(
                  event.ingredients,
                  style: Get.textTheme.bodySmall,
                ),
                const SizedBox(
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Description : "),
                      Divider(
                        thickness: 1.5,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ],
                  ),
                ),
                Text(
                  event.description,
                  style: Get.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomEventExercise extends StatelessWidget {
  final ExerciseEventItem event;
  final DateTime eventStartAt;
  final DateTime eventEndAt;
  final int progress;

  const CustomEventExercise(
      {super.key,
      required this.event,
      required this.eventStartAt,
      required this.eventEndAt,
      required this.progress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showInfoDialog,
      child: Column(
        children: [
          Row(
            children: [
              const Text("Name : "),
              CustomEventText(text: event.name),
            ],
          ),
          Row(
            children: [
              const Text("Type : "),
              CustomEventText(text: event.type),
            ],
          ),
          Row(
            children: [
              const Text("Equipment : "),
              CustomEventText(text: event.equipment),
            ],
          ),
          Row(
            children: [
              const Text("Duration : "),
              CustomEventText(text: event.duration),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularPercentIndicator(
                radius: 20.0,
                lineWidth: 5.0,
                percent: (progress / 100),
                center: progress != 100
                    ? Text(
                        "$progress%",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      )
                    : const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                progressColor:
                    progress != 100 ? Get.theme.primaryColor : Colors.green,
              ),
              CustomEventDateWidget(
                  eventStartAt: eventStartAt, eventEndAt: eventEndAt),
            ],
          ),
        ],
      ),
    );
  }

  void _showInfoDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text(event.name, style: Get.textTheme.displaySmall),
        content: SizedBox(
          height: 500,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Media : "),
                      Divider(
                        thickness: 1.5,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ],
                  ),
                ),
                if (event.media != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      event.media!,
                      loadingBuilder:
                          (_, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(251, 99, 64, 1),
                          ),
                        );
                      },
                    ),
                  ),
                Container(
                  width: 120,
                  margin: const EdgeInsets.only(top: 25),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Description : "),
                      Divider(
                        thickness: 1.5,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ],
                  ),
                ),
                Text(
                  event.description,
                  style: Get.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomEventText extends StatelessWidget {
  const CustomEventText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Get.textTheme.bodySmall,
      ),
    );
  }
}

class CustomEventDateWidget extends StatelessWidget {
  const CustomEventDateWidget({
    super.key,
    required this.eventStartAt,
    required this.eventEndAt,
  });

  final DateTime eventStartAt;
  final DateTime eventEndAt;

  @override
  Widget build(BuildContext context) {
    return Text(
      _getDate(),
      style: const TextStyle(
        fontSize: 14,
      ),
    );
  }

  String _getDate() {
    return "${DateFormat('hh:mm a').format(eventStartAt)}  -> ${DateFormat('hh:mm a').format(eventEndAt)} ";
  }

  String _fixDigit(int digit) => digit >= 9 ? "$digit" : "0$digit";
}
