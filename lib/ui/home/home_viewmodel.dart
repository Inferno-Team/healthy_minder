import 'dart:convert';

import 'package:dart_pusher_channels/dart_pusher_channels.dart'
    as pusher_channels;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/channel.dart';
import 'package:healthy_minder/models/premium_status.dart';
import 'package:healthy_minder/models/return_types.dart';
import 'package:healthy_minder/models/saved_user.dart';
import 'package:healthy_minder/models/timeline_event.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/socket/pusher_socket.dart';
import 'package:healthy_minder/ui/chat_feature/all_chat/all_chat_binding.dart';
import 'package:healthy_minder/ui/chat_feature/all_chat/all_chat_screen.dart';
import 'package:healthy_minder/ui/chat_feature/chat/chat_binding.dart';
import 'package:healthy_minder/ui/chat_feature/chat/chat_screen.dart';
import 'package:healthy_minder/ui/chat_feature/coach_chat/coach_chat_binding.dart';
import 'package:healthy_minder/ui/chat_feature/coach_chat/coach_chat_screen.dart';
import 'package:healthy_minder/ui/chat_feature/new_chat/new_chat_binding.dart';
import 'package:healthy_minder/ui/chat_feature/new_chat/new_chat_screen.dart';
import 'package:healthy_minder/ui/home/home_screen.dart';
import 'package:healthy_minder/ui/my_progress/my_progress_bindings.dart';
import 'package:healthy_minder/ui/my_progress/my_progress_screen.dart';
import 'package:healthy_minder/ui/notifications/notification_bindings.dart';
import 'package:healthy_minder/ui/notifications/notification_screen.dart';
import 'package:healthy_minder/ui/premium/premium_binding.dart';
import 'package:healthy_minder/ui/premium/premium_screen.dart';
import 'package:healthy_minder/ui/settings/settings_binding.dart';
import 'package:healthy_minder/ui/settings/settings_screen.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'package:healthy_minder/models/notification.dart' as not;
import 'package:kalender/kalender.dart';

class HomeViewModel extends GetxController {
  final DataService dataService;

  HomeViewModel({required this.dataService});

  Rx<PremiumStatus> premiumStatus = PremiumStatus.empty().obs;
  final unreadNotifications = RxList<not.Notification>.empty();
  final todayEvents = RxList<TimelineEvent>.empty();
  final timelineEvents = RxList<TimelineEvent>.empty();
  bool isTodayEventsLoading = true;
  bool isTimelineEventsLoading = true;
  final _savedUser = SavedUser.empty().obs;

  SavedUser get savedUser => _savedUser.value;

  final _xOffset = 0.0.obs;
  final _yOffset = 0.0.obs;
  final _rotateZValue = 0.0.obs;
  final _xShadowOffset = 0.0.obs;
  final _isDrawerOpen = false.obs;
  final _direction = TextDirection.ltr.obs;
  TextDirection get direction => _direction.value;
  final _directionString = 'ltr'.obs;
  final _currentRoute = ''.obs;
  final _currentPath = ''.obs;

  final _currentActive = DrawerItem.home.obs;
  final _messageFromSubPage = ''.obs;

  DrawerItem get current => _currentActive.value;

  String get message => _messageFromSubPage.value;
  List<ViewConfiguration> viewConfigurations = [
    DayConfiguration(
      timeIndicatorSnapping: true,
      verticalStepDuration: const Duration(minutes: 30),
      initialHeightPerMinute: 1.5,
      enableRescheduling: false,
      enableResizing: false,
    ),
  ];
  final calendarController = CalendarController<TimelineEvent>(
    initialDate: DateTime.now(),
  );
  CalendarEventsController<TimelineEvent> eventController =
      CalendarEventsController();

  final currentConfiguration = Rxn<ViewConfiguration>();

  void setMessage(String msg) => _messageFromSubPage.value = msg;

  changeCurrent(DrawerItem value) {
    toggleMenu();
    changeCurrentRoute(value.name);
    print(value.toString());
    Get.toNamed(value.toString(), id: 1);
    _currentActive.value = value;
  }

  bool get isDrawerOpen => _isDrawerOpen.value;

  double get xOffset => _xOffset.value;

  double get yOffset => _yOffset.value;

  double get rotateZValue => _rotateZValue.value;

  double get xShadowOffset => _xShadowOffset.value;

  @override
  void onInit() async {
    String token = StorageHelper.getToken();
    currentConfiguration.value = viewConfigurations[0];
    dataService.getTodayEvents(token).then((value) {
      isTodayEventsLoading = false;
      if (value != null && value is ReturnDataType<List<TimelineEvent>?>?) {
        todayEvents.value =
            (value as ReturnDataType<List<TimelineEvent>?>).data!;
      }
    });
    StorageHelper.registerLanguageCallback((lang) {
      String language = lang.toString();
      _direction.value = StorageHelper.getTextDirection();
      _directionString.value = StorageHelper.getTextDirection().name;
      _calcShadowOffset();
      if(!isDrawerOpen)return;
      if (language == 'en') {
        _xOffset.value = 200;
        _yOffset.value = 80;
        _rotateZValue.value = 50;
      } else {
        _xOffset.value = -120;
        _yOffset.value = 80;
        _rotateZValue.value = -50;
        // -50
      }
    },);

    dataService.getTimelineEvents(token).then((value) {
      isTimelineEventsLoading = false;
      if (value != null && value is ReturnDataType<List<TimelineEvent>?>?) {
        timelineEvents.value =
            (value as ReturnDataType<List<TimelineEvent>?>).data!;
        for (TimelineEvent event in timelineEvents) {
          CalendarEvent<TimelineEvent> eventTime = CalendarEvent<TimelineEvent>(
            eventData: event,
            dateTimeRange: DateTimeRange(
              start: event.eventStartAt,
              end: event.eventEndAt,
            ),
          );
          eventController.addEvent(eventTime);
        }
      }
    });

    dataService.loadMyUnreadNotifications(token).then((value) {
      if (value != null && value is ReturnDataType<List<not.Notification>?>?) {
        unreadNotifications.value =
            (value as ReturnDataType<List<not.Notification>?>).data!;
      }
    });
    _savedUser.value = StorageHelper.getUser();
    StorageHelper.storage.listenKey(Constance.savedUser, (value) {
      _savedUser.value = StorageHelper.getUser();
    });
    // print(StorageHelper.getUser().channels.map((e) => e.toJsonString()));
    ReturnType<PremiumStatus?>? response =
        await dataService.myPremiumStatus(token);
    if (response is ReturnDataType) {
      PremiumStatus? premiumStatusNullable =
          (response as ReturnDataType<PremiumStatus?>).data;
      premiumStatus.value = premiumStatusNullable ?? PremiumStatus.empty();
    }
    _direction.value = StorageHelper.getTextDirection();
    _directionString.value = StorageHelper.getTextDirection().name;
    _calcShadowOffset();
    _currentPath.value = '/home';
    _currentRoute.value = 'home';
    super.onInit();
    await PusherSocket().init(local: true);
    PusherSocket()
        .connectToUserChannel(token, StorageHelper.getUser().username, {
      "PremiumStatusChanged": (pusher_channels.ChannelReadEvent event) {
        String data = event.data;
        print(data);
        Map<String, dynamic> map = json.decode(data);
        premiumStatus.value = PremiumStatus.fromJson(map);
      },
      "NewMessage": (pusher_channels.ChannelReadEvent event) {
        var data = json.decode(event.data);
        not.Notification notification = not.Notification(
          id: data['id'],
          body: data['sender']['fullname'] + " : " + data['message']['message'],
          timestamp: DateTime.parse(data['message']['created_at'])
              .millisecondsSinceEpoch,
          title: data['conversation']['name'],
          avatar: data['conversation']['avatar'],
        );
        unreadNotifications.value = [...unreadNotifications, notification];
      },
      "NewEventNotification":(pusher_channels.ChannelReadEvent event){
        var data = json.decode(event.data);
        print(data);
        not.Notification notification = not.Notification(
          id: data['id'],
          body: data['message'],
          timestamp: DateTime.parse(data['created_at'])
              .millisecondsSinceEpoch,
          title: data['title'],
          // avatar: data['conversation']['avatar'],
        );
        unreadNotifications.value = [...unreadNotifications, notification];
      }
    });
  }

  void _calcShadowOffset() {
    _directionString.value == TextDirection.ltr.name
        ? _xShadowOffset.value = -10.0
        : _xShadowOffset.value = 10.0;
  }

  void toggleMenu() {
    String lang = StorageHelper.getSavedLanguage() ?? 'en';
    if (lang == 'en') {
      _xOffset.value = 200;
      _yOffset.value = 80;
      _rotateZValue.value = 50;
    } else {
      _xOffset.value = -120;
      _yOffset.value = 80;
      _rotateZValue.value = -50;
    }

    if (isDrawerOpen) {
      _yOffset.value = 0;
      _xOffset.value = 0;
      _rotateZValue.value = 0;
    }

    _isDrawerOpen.value = !_isDrawerOpen.value;
    update();
  }



  Future<bool> onBackPressed(bool? value) async {
    final routes =
        _currentPath.split('/'); // /home/gyms/gym => ['',home,gyms,gym]
    // print(routes);
    // print(routes.length);
    if (routes.length > 2) {
      _currentPath.value = '';
      // state: nesting
      // remove last route name.
      routes.removeAt(0);
      routes.removeLast();

      // rebuild the route
      for (var element in routes) {
        _currentPath.value += '/$element'; // /home , /home/gyms
      }
      var lastRoute = routes.last;
      _currentActive.value = DrawerItem.fromRoute(lastRoute);
      // print(_currentRoute.value);
    } else {
      // need to close the app
      SystemNavigator.pop();
      return true;
    }

    Get.back(id: 1);
    if (isDrawerOpen) toggleMenu();
    return false;
  }

  void changeCurrentRoute(String value) {
    _currentPath.value += "/$value";
    _currentRoute.value = value;

  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HealthyRoutes.homeScreenRoute:
        return GetPageRoute(
          settings: settings,
          page: () => HomeScreen(),
          transition: Transition.zoom,
        );
      case HealthyRoutes.notificationScreenRoute:
        return GetPageRoute(
          settings: settings,
          page: () => const NotificationScreen(),
          binding: NotificationBindings(),
          transition: Transition.zoom,
        );
      case HealthyRoutes.chatsPageRoute:
        Channel channel = StorageHelper.getUser().channels.firstWhere(
              (element) =>
                  element.id == 1 && element.type == ChannelType.presence,
            );
        return GetPageRoute(
          settings: settings,
          page: () => ChatScreen(channel: channel),
          binding: ChatBinding(),
          transition: Transition.zoom,
        );
      case HealthyRoutes.coachChatPageRoute:
        return GetPageRoute(
          settings: settings,
          page: () => const CoachChatScreen(),
          binding: CoachChatBinding(),
          transition: Transition.zoom,
        );
      case HealthyRoutes.newMessageRoute:
        return GetPageRoute(
          settings: settings,
          page: () => const NewChatScreen(),
          binding: NewChatBindings(),
          transition: Transition.zoom,
        );
      case HealthyRoutes.premiumScreenRoute:
        return GetPageRoute(
          settings: settings,
          page: () => const PremiumScreen(),
          binding: PremiumBinding(),
          transition: Transition.zoom,
        );
      case HealthyRoutes.settingsScreenRoute:
        return GetPageRoute(
          settings: settings,
          page: () => const SettingsScreen(),
          transition: Transition.zoom,
          binding: SettingsBinding(),
        );
      case HealthyRoutes.myProgressScreenRoute:
        return GetPageRoute(
          settings: settings,
          page: () => const MyProgressScreen(),
          transition: Transition.zoom,
          binding: MyProgressBindings(),
        );

      default:
        return GetPageRoute(
          settings: settings,
          page: () => HomeScreen(),
          transition: Transition.zoom,
        );
    }
  }

  void logout() {
    StorageHelper.logout();
    Get.offNamed(HealthyRoutes.loginRoute);
  }

  openNotification() {
    DrawerItem value = DrawerItem.notification;
    changeCurrentRoute(value.name);
    Get.toNamed(value.toString(), id: 1);
    _currentActive.value = value;
  }

  @override
  void onClose() {
    PusherSocket().disconnect();
    super.onClose();
  }

  Future<void> onHomeScreenRefresh() async {
    isTodayEventsLoading = true;
    isTimelineEventsLoading = true;
    String token = StorageHelper.getToken();
    todayEvents.value = [];
    timelineEvents.value = [];

    dataService.getTodayEvents(token).then((value) {
      isTodayEventsLoading = false;
      if (value != null && value is ReturnDataType<List<TimelineEvent>?>?) {
        todayEvents.value =
            (value as ReturnDataType<List<TimelineEvent>?>).data!;
      }
    });
    eventController.clearEvents();
    dataService.getTimelineEvents(token).then((value) {
      isTimelineEventsLoading = false;
      if (value != null && value is ReturnDataType<List<TimelineEvent>?>?) {
        timelineEvents.value =
            (value as ReturnDataType<List<TimelineEvent>?>).data!;
        for (TimelineEvent event in timelineEvents) {
          CalendarEvent<TimelineEvent> eventTime = CalendarEvent<TimelineEvent>(
            eventData: event,
            dateTimeRange: DateTimeRange(
              start: event.eventStartAt,
              end: event.eventEndAt,
            ),
          );
          eventController.addEvent(eventTime);
        }
      }
    });
  }

  void updateCurrentConfiguration(ViewConfiguration? value) {
    if (value != null) {
      currentConfiguration.value = value;
    }
  }

  void showMealInfoDialog(MealEventItem event) {
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
                IntrinsicWidth(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Quantity : "),
                            Text(
                              "${event.qty} ${event.qtyType}",
                              style: Get.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1.5,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                IntrinsicWidth(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Meal Type : "),
                            Text(
                              event.type,
                              style: Get.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1.5,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                const IntrinsicWidth(
                  child: SizedBox(
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

  void showExerciseInfoDialog(ExerciseEventItem event) {
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
                IntrinsicWidth(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Type : "),
                            Text(
                              event.type,
                              style: Get.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1.5,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                IntrinsicWidth(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Equipment : "),
                            Text(
                              event.equipment,
                              style: Get.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1.5,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                IntrinsicWidth(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Duration : "),
                            Text(
                              event.duration,
                              style: Get.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1.5,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
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

enum DrawerItem {
  home('home'),
  message('message'),
  coachMessage('coachMessage'),
  premium('premium'),
  settings('settings'),
  myProgress("myProgress"),
  notification('notification'),
  other("other");

  final String _text;

  const DrawerItem(this._text);

  @override
  String toString() {
    switch (_text) {
      case "home":
        return HealthyRoutes.homeScreenRoute;
      case "message":
        return HealthyRoutes.chatsPageRoute;
      case "premium":
        return HealthyRoutes.premiumScreenRoute;
      case "myProgress":
        return HealthyRoutes.myProgressScreenRoute;
      case "notification":
        return HealthyRoutes.notificationScreenRoute;
      case "settings":
        return HealthyRoutes.settingsScreenRoute;
      case "coachMessage":
        return HealthyRoutes.coachChatPageRoute;

      default:
        return HealthyRoutes.homeScreenRoute;
    }
  }

  static DrawerItem fromRoute(String route) {
    switch (route) {
      case HealthyRoutes.homeScreenRoute:
        return DrawerItem.home;
      case HealthyRoutes.premiumScreenRoute:
        return DrawerItem.premium;
      case HealthyRoutes.chatsPageRoute:
        return DrawerItem.message;
      case HealthyRoutes.notificationScreenRoute:
        return DrawerItem.notification;
      case HealthyRoutes.settingsScreenRoute:
        return DrawerItem.settings;
      case HealthyRoutes.myProgressScreenRoute:
        return DrawerItem.myProgress;
      default:
        return DrawerItem.home;
    }
  }
}
