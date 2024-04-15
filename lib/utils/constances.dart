import 'package:get/get.dart';
import 'package:healthy_minder/ui/auth/login/login_binding.dart';
import 'package:healthy_minder/ui/auth/login/login_page.dart';
import 'package:healthy_minder/ui/auth/signup/signup_binding.dart';
import 'package:healthy_minder/ui/auth/signup/signup_page.dart';
import 'package:healthy_minder/ui/home/home_biding.dart';
import 'package:healthy_minder/ui/home/home_page.dart';
import 'package:healthy_minder/ui/welcome/welcome_binding.dart';
import 'package:healthy_minder/ui/welcome/welcome_page.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class Constance {
  static const String loginState = 'login_state';
  static const String savedUser = 'saved_user';
  static const String themeState = 'light';
  static const String tokenValue = 'token_value';
  static const String languageValue = 'language';
  static const int NUMBER_LENGTH = 10;
  static const String phoneCode = '+966';
}

class HealthyRoutes {
  static const String welcomeRoute = '/welcome';
  static const String oldUserPasswordRoute = '/old-user-password-page';
  static const String newUserPageRoute = '/new-user-page';
  static const String homePageRoute = '/home';
  static const String mapPageRoute = '/map';
  static const String setNamePageRoute = '/set-name';

  static const String allClientScreenRoute = '/home-inner-screen';
  static const String readyScreenRoute = '/ready-screen';
  static const String lateScreenRoute = '/late-screen';
  static const String addPackageScreenRoute = '/add-package-screen';

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: HealthyRoutes.welcomeRoute,
        page: () => const WelcomePage(),
        binding: WelcomeBinding(),
        transition: Transition.zoom,
      ),
      GetPage(
        name: HealthyRoutes.oldUserPasswordRoute,
        page: () => const loginPage(),
        binding: LoginBinding(),
        transition: Transition.zoom,
      ),
      GetPage(
        name: HealthyRoutes.newUserPageRoute,
        page: () => const signUpPage(),
        binding: SignUpBinding(),
        transition: Transition.zoom,
      ),
      GetPage(
        name: HealthyRoutes.homePageRoute,
        page: () => const homepage(),
        binding: HomeBinding(),
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
    Get.put(StorageHelper());
    // Get.put(DataService());
    // Get.put(LocalDatabase());
  }
}
