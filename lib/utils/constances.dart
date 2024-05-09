import 'package:get/get.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/ui/auth/login/login_binding.dart';
import 'package:healthy_minder/ui/auth/login/login_page.dart';
import 'package:healthy_minder/ui/auth/signup/first_signup/signup_binding.dart';
import 'package:healthy_minder/ui/auth/signup/first_signup/signup_page.dart';
import 'package:healthy_minder/ui/auth/signup/second_signup/personal_info.dart';
import 'package:healthy_minder/ui/auth/signup/second_signup/personal_info_binding.dart';
import 'package:healthy_minder/ui/auth/signup/final_signup/final_signup_binding.dart';
import 'package:healthy_minder/ui/auth/signup/final_signup/final_signup_page.dart';
import 'package:healthy_minder/ui/home/home_biding.dart';
import 'package:healthy_minder/ui/home/home_page.dart';
import 'package:healthy_minder/ui/premium/premium_binding.dart';
import 'package:healthy_minder/ui/premium/premium_screen.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class Constance {
  static const String loginState = 'login_state';
  static const String savedUser = 'saved_user';
  static const String themeState = 'light';
  static const String tokenValue = 'token_value';
  static const String languageValue = 'language';
  // static const String hostName = "192.168.251.160";
  static const String hostName = "192.168.1.7";
}

class HealthyRoutes {
  static const String welcomeRoute = '/drawer';
  static const String loginRoute = '/login-page';
  static const String firstSignupRoute = '/first-signup-page';
  static const String secondSignupRoute = '/second-signup-page';
  static const String finalSignupRoute = '/third-signup-page';
  static const String homePageRoute = '/home';
  static const String chatsPageRoute = '/chats-page';
  static const String allChatsPageRoute = '/all-chats-page';
  static const String sendMessageRoute = '/send-message-page';
  static const String preimumPageRoute = '/preimum-page';
  static const String homeScreenRoute = '/home/home-screen';
  static const String notificationScreenRoute = '/notification-screen';

  static const String premiumScreenRoute = '/preimum-screen';
  static const String lateScreenRoute = '/late-screen';
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
        binding: SignUpBinding(),
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
        binding: PersonalInfoBinding(),
        transition: Transition.zoom,
      ),
      GetPage(
        name: HealthyRoutes.finalSignupRoute,
        page: () => const ThirdSignupPage(),
        binding: ThirdSignupBinding(),
        transition: Transition.zoom,
      ),
      GetPage(
        name: HealthyRoutes.preimumPageRoute,
        page: () => const PremiumScreen(),
        binding: PremiumBinding(),
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
