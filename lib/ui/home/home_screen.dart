import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/gen/assets.gen.dart';
import 'package:healthy_minder/models/timeline_event.dart';
import 'package:healthy_minder/ui/custom/custom_event_widget.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';
import 'package:healthy_minder/utils/translator.dart';
import 'package:kalender/kalender.dart';

class HomeScreen extends GetView<HomeViewModel> {
  final List imgList = [
    Assets.images.img01.path,
    Assets.images.img02.path,
    Assets.images.img03.path,
  ];

  HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: controller.onHomeScreenRefresh,
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  Keys.todayEvents.name.tr,
                  style: Get.textTheme.bodyMedium,
                ),
              ),
            ),
            Obx(
              () => controller.todayEvents.isNotEmpty
                  ? CarouselSlider(
                      options: CarouselOptions(
                        height: size.height * 0.24,
                        aspectRatio: 16 / 9,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        pauseAutoPlayOnTouch: true,
                        enlargeCenterPage: false,
                      ),
                      items: controller.todayEvents
                          .map((event) => EventWidget(event: event))
                          .toList())
                  : controller.isTodayEventsLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(251, 99, 64, 1),
                          ),
                        )
                      : const Center(
                          child: Text(
                            "No Event For Today.",
                          ),
                        ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Timeline's Events",
                  style: Get.textTheme.bodyMedium,
                ),
              ),
            ),
            Obx(
              () => controller.timelineEvents.isNotEmpty
                  ? SizedBox(
                      height: size.height * 0.7,
                      width: size.width,
                      child: CalendarView<TimelineEvent>(
                        controller: controller.calendarController,
                        eventsController: controller.eventController,
                        viewConfiguration:
                            controller.currentConfiguration.value!,
                        tileBuilder: _tileBuilder,
                        multiDayTileBuilder: _multiDayTileBuilder,
                        scheduleTileBuilder: _scheduleTileBuilder,
                        components: CalendarComponents(
                          calendarHeaderBuilder: _calendarHeader,
                        ),
                        eventHandlers: CalendarEventHandlers(
                          onEventTapped: _onEventTapped,
                          // onEventChanged: _onEventChanged,
                          // onCreateEvent: _onCreateEvent,
                          // onEventCreated: _onEventCreated,
                        ),
                      ),
                    )
                  : controller.isTimelineEventsLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(251, 99, 64, 1),
                          ),
                        )
                      : const Center(
                          child: Text(
                            "Timeline Don't have events yet.",
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onEventTapped(
    CalendarEvent<TimelineEvent> event,
  ) async {
    controller.eventController.selectedEvent == event
        ? controller.eventController.deselectEvent()
        : controller.eventController.selectEvent(event);
    if (event.eventData?.itemType == 'Meal') {
      controller
          .showMealInfoDialog(event.eventData?.eventItem as MealEventItem);
    } else {
      controller.showExerciseInfoDialog(
          event.eventData?.eventItem as ExerciseEventItem);
    }
  }

  Widget _tileBuilder(
    CalendarEvent<TimelineEvent> event,
    TileConfiguration configuration,
  ) {
    Color color;
    switch (event.eventData?.itemType) {
      case "Meal":
        color = const Color(0xFF1c7541);
        break;
      case "Exercise":
        color = const Color(0xff291c75);
        break;
      default:
        color = Colors.blue;
    }
    // const color = Colors.blue;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.zero,
      elevation: configuration.tileType == TileType.ghost ? 0 : 8,
      color: configuration.tileType != TileType.ghost
          ? color
          : color.withAlpha(100),
      child: Center(
        child: configuration.tileType != TileType.ghost
            ? Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${event.eventData?.itemType} : ",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          event.eventData?.eventItem.name ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  CustomEventDateWidget(
                    eventStartAt: event.start,
                    eventEndAt: event.end,
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget _multiDayTileBuilder(
    CalendarEvent<TimelineEvent> event,
    MultiDayTileConfiguration configuration,
  ) {
    final color = Colors.blue;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      elevation: configuration.tileType == TileType.selected ? 8 : 0,
      color: configuration.tileType == TileType.ghost
          ? color.withAlpha(100)
          : color,
      child: Center(
        child: configuration.tileType != TileType.ghost
            ? Text(event.eventData?.itemType ?? 'New TimelineEvent')
            : null,
      ),
    );
  }

  Widget _scheduleTileBuilder(
      CalendarEvent<TimelineEvent> event, DateTime date) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(event.eventData?.itemType ?? 'New TimelineEvent'),
    );
  }

  Widget _calendarHeader(DateTimeRange dateTimeRange) {
    return Row(
      children: [
        IconButton.filledTonal(
          onPressed: controller.calendarController.animateToPreviousPage,
          icon: const Icon(Icons.navigate_before_rounded),
        ),
        IconButton.filledTonal(
          onPressed: controller.calendarController.animateToNextPage,
          icon: const Icon(Icons.navigate_next_rounded),
        ),
        IconButton.filledTonal(
          onPressed: () {
            controller.calendarController.animateToDate(DateTime.now());
          },
          icon: const Icon(Icons.today),
        ),
      ],
    );
  }
}
