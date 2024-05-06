import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/chat_feature/chat/chat_binding.dart';
import 'package:healthy_minder/ui/chat_feature/chat/chat_screen.dart';
import 'package:healthy_minder/ui/home/home_screen.dart';
import 'package:healthy_minder/ui/notifications/notification_screen.dart';
import 'package:healthy_minder/ui/premium/premium_binding.dart';
import 'package:healthy_minder/ui/premium/premium_screen.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class HomeViewModel extends GetxController {
  final _xOffset = 0.0.obs;
  final _yOffset = 0.0.obs;
  final _xShadowOffset = 0.0.obs;
  final _isDrawerOpen = false.obs;
  final _direction = TextDirection.ltr.obs;
  final _directionString = 'ltr'.obs;
  final _currentRoute = ''.obs;
  final _currentPath = ''.obs;

  final _currentActive = DrawerItem.home.obs;

  DrawerItem get current => _currentActive.value;

  changeCurrent(DrawerItem value) {
    toggleMenu();
    print("1: ${value.name}");
    print("2: $value");
    changeCurrentRoute(value.name);
    Get.toNamed(value.toString(), id: 1);
    _currentActive.value = value;
  }

  bool get isDrawerOpen => _isDrawerOpen.value;

  double get xOffset => _xOffset.value;

  double get yOffset => _yOffset.value;

  double get xShadowOffset => _xShadowOffset.value;

  @override
  void onInit() {
    _direction.value = StorageHelper.getTextDirection();
    _directionString.value = StorageHelper.getTextDirection().name;
    _calcShadowOffset();
    _currentPath.value = '/home';
    _currentRoute.value = 'home';
    super.onInit();
  }

  void _calcShadowOffset() {
    _directionString.value == TextDirection.ltr.name
        ? _xShadowOffset.value = -10.0
        : _xShadowOffset.value = 10.0;
  }

  void toggleMenu() {
    String lang = StorageHelper.getSavedLanguage() ?? 'en';
    if (lang == 'en') {
      _xOffset.value = 330;
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
    toggleMenu();
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
          transition: Transition.zoom,
        );
      case HealthyRoutes.chatsPageRoute:
        return GetPageRoute(
          settings: settings,
          page: () => ChatScreen(),
          binding: ChatBinding(),
          transition: Transition.zoom,
        );
      case HealthyRoutes.premiumScreenRoute:
        return GetPageRoute(
          settings: settings,
          page: () => const PremiumScreen(),
          binding: PremiumBinding(),
          transition: Transition.zoom,
        );
      default:
        return GetPageRoute(
          settings: settings,
          page: () => HomeScreen(),
          transition: Transition.zoom,
        );
    }
  }
}

enum DrawerItem {
  home('home'),
  message('message'),
  premium('preimum-screen'),
  notification('notification');

  final String _text;

  const DrawerItem(this._text);

  @override
  String toString() {
    print('3. $_text');
    switch (_text) {
      case "home":
        return HealthyRoutes.homeScreenRoute;
      case "message":
        return HealthyRoutes.chatsPageRoute;
      case "preimum-screen":
        return HealthyRoutes.premiumScreenRoute;
      case "notification":
        return HealthyRoutes.notificationScreenRoute;

      default:
        return HealthyRoutes.homeScreenRoute;
    }
  }

  static DrawerItem fromRoute(String route) {
    print(route);
    switch (route) {
      case HealthyRoutes.homeScreenRoute:
        return DrawerItem.home;
      case HealthyRoutes.premiumScreenRoute:
        return DrawerItem.premium;
      // case HealthyRoutes.homeScreenRoute:
      //   return DrawerItem.premium;
      case HealthyRoutes.notificationScreenRoute:
        return DrawerItem.notification;

      default:
        return DrawerItem.home;
    }
  }
}
