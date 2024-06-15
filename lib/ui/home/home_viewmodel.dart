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
import 'package:healthy_minder/ui/notifications/notification_bindings.dart';
import 'package:healthy_minder/ui/notifications/notification_screen.dart';
import 'package:healthy_minder/ui/premium/premium_binding.dart';
import 'package:healthy_minder/ui/premium/premium_screen.dart';
import 'package:healthy_minder/ui/settings/settings_binding.dart';
import 'package:healthy_minder/ui/settings/settings_screen.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'package:healthy_minder/models/notification.dart' as not;

class HomeViewModel extends GetxController {
  final DataService dataService;

  HomeViewModel({required this.dataService});

  Rx<PremiumStatus> premiumStatus = PremiumStatus.empty().obs;
  final unreadNotifications = RxList<not.Notification>.empty();
  final _savedUser = SavedUser.empty().obs;

  SavedUser get savedUser => _savedUser.value;

  final _xOffset = 0.0.obs;
  final _yOffset = 0.0.obs;
  final _xShadowOffset = 0.0.obs;
  final _isDrawerOpen = false.obs;
  final _direction = TextDirection.ltr.obs;
  final _directionString = 'ltr'.obs;
  final _currentRoute = ''.obs;
  final _currentPath = ''.obs;

  final _currentActive = DrawerItem.home.obs;
  final _messageFromSubPage = ''.obs;

  DrawerItem get current => _currentActive.value;

  String get message => _messageFromSubPage.value;

  void setMessage(String msg) => _messageFromSubPage.value = msg;

  changeCurrent(DrawerItem value) {
    toggleMenu();
    changeCurrentRoute(value.name);
    Get.toNamed(value.toString(), id: 1);
    _currentActive.value = value;
  }

  bool get isDrawerOpen => _isDrawerOpen.value;

  double get xOffset => _xOffset.value;

  double get yOffset => _yOffset.value;

  double get xShadowOffset => _xShadowOffset.value;

  @override
  void onInit() async {
    String token = StorageHelper.getToken();
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
    await PusherSocket().init();
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
    } else {
      _xOffset.value = 0;
    }
    _yOffset.value = 80;
    if (isDrawerOpen) {
      _yOffset.value = 0;
      _xOffset.value = 0;
    }

    _isDrawerOpen.value = !_isDrawerOpen.value;
    update();
  }

  void toggleLanguage() {
    toggleMenu();
    Get.locale = StorageHelper.swipeLanguage();
    // _toggleDirection();
    _calcShadowOffset();
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
          page: () => PremiumScreen(),
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
}

enum DrawerItem {
  home('home'),
  message('message'),
  coachMessage('coachMessage'),
  premium('premium'),
  settings('settings'),
  notification('notification');

  final String _text;

  const DrawerItem(this._text);

  @override
  String toString() {
    switch (_text) {
      case "home":
        return HealthyRoutes.homeScreenRoute;
      case "message":
        return /*HomeViewModel.premiumStatus.value.status == "approved"
            ? HealthyRoutes.allChatsPageRoute
            :*/
            HealthyRoutes.chatsPageRoute;
      case "premium":
        return HealthyRoutes.premiumScreenRoute;
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

      default:
        return DrawerItem.home;
    }
  }
}
