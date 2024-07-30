import 'package:get/get.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/ui/auth/login/login_binding.dart';
import 'package:healthy_minder/ui/auth/login/login_page.dart';
import 'package:healthy_minder/ui/auth/plans/select_plan_bindings.dart';
import 'package:healthy_minder/ui/auth/plans/select_plan_page.dart';
import 'package:healthy_minder/ui/auth/signup/first_signup/signup_page.dart';
import 'package:healthy_minder/ui/auth/signup/second_signup/personal_info.dart';

import 'package:healthy_minder/ui/auth/signup/final_signup/final_signup_page.dart';
import 'package:healthy_minder/ui/auth/signup/signup_bindings.dart';
import 'package:healthy_minder/ui/home/home_biding.dart';
import 'package:healthy_minder/ui/home/home_page.dart';
import 'package:healthy_minder/ui/premium/premium_binding.dart';
import 'package:healthy_minder/ui/premium/premium_screen.dart';
import 'package:healthy_minder/ui/settings/settings_binding.dart';
import 'package:healthy_minder/ui/settings/settings_screen.dart';

import 'package:healthy_minder/utils/storage_helper.dart';

class Constance {
  static const String loginState = 'login_state';
  static const String savedUser = 'saved_user';
  static const String themeState = 'light';
  static const String tokenValue = 'token_value';
  static const String languageValue = 'language';
  static const String currentStep = 'current_step';
  static const String otherValues = 'other_values';

  // static const String hostName = "192.168.137.160";
  static const String hostName = "192.168.1.7";
  // static const String hostName = "healthy.digiworld-dev.com";
  //   static const String fullHostName = "https://$hostName";
  // static const String hostName = "192.168.63.160";
  static const String fullHostName = "http://$hostName:8000";
}

class HealthyRoutes {
  static const String welcomeRoute = '/drawer';
  static const String loginRoute = '/login-page';
  static const String firstSignupRoute = '/first-signup-page';
  static const String secondSignupRoute = '/second-signup-page';
  static const String finalSignupRoute = '/third-signup-page';
  static const String homePageRoute = '/home';
  static const String chatsPageRoute = '/chats-page';
  static const String coachChatPageRoute = '/all-chats-page';
  static const String sendMessageRoute = '/send-message-page';
  static const String newMessageRoute = '/new-message-page';
  static const String preimumPageRoute = '/preimum-page';
  static const String homeScreenRoute = '/home/home-screen';
  static const String notificationScreenRoute = '/notification-screen';
  static const String selectPlanRoute = '/select-plan-route';

  static const String premiumScreenRoute = '/preimum-screen';
  static const String myProgressScreenRoute = '/myProgress-screen';
  static const String settingsScreenRoute = '/settings-screen';
  static const String addPackageScreenRoute = '/add-package-screen';

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: HealthyRoutes.loginRoute,
        page: () => const LoginPage(),
        binding: LoginBinding(),
        transition: Transition.zoom,
      ),
      GetPage(
        name: HealthyRoutes.firstSignupRoute,
        page: () => const SignUpPage(),
        binding: SignupBinding(),
        transition: Transition.zoom,
      ),
      GetPage(
        name: HealthyRoutes.homePageRoute,
        page: () => const HomePage(),
        binding: HomeBinding(),
        transition: Transition.zoom,
      ),
      GetPage(
        name: HealthyRoutes.secondSignupRoute,
        page: () => const SecondSignupPage(),
        transition: Transition.zoom,
      ),
      GetPage(
        name: HealthyRoutes.finalSignupRoute,
        page: () => const ThirdSignupPage(),
        transition: Transition.zoom,
      ),
      GetPage(
        name: HealthyRoutes.preimumPageRoute,
        page: () =>  PremiumScreen(),
        binding: PremiumBinding(),
        transition: Transition.zoom,
      ),
      GetPage(
        name: HealthyRoutes.settingsScreenRoute,
        page: () => const SettingsScreen(),
        binding: SettingsBinding(),
        transition: Transition.zoom,
      ),
      GetPage(
        name: HealthyRoutes.selectPlanRoute,
        page: () => const SelectPlanPage(),
        binding: SelectPlanBindings(),
        transition: Transition.zoom,
      ),
    ];
  }
}

int? convert2int(value) =>
    (value != null && value is String) ? int.tryParse(value) ?? 0 : null;

class InitialGetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DataService());
    // Get.put(LocalDatabase());
  }
}
