import 'package:get/get.dart';

class Translator extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar_SY': {
          Keys.password.name: 'كلمة المرور',
          Keys.loginTitle.name: 'قم بتسجيل الدخول لحسابك',
          Keys.email.name: 'بريد الالكتروني',
          Keys.doNotHaveAccount.name: 'لا تمتلك حساب ؟',
          Keys.registerNow.name: 'انشئ حساب',
          Keys.login.name: 'تسجيل الدخول',
        },
        'en_US': {
          Keys.password.name: 'Password',
          Keys.loginTitle.name: 'Log in to your account',
          Keys.email.name: 'Email',
          Keys.doNotHaveAccount.name: 'Don\'t have an account? ',
          Keys.registerNow.name: 'Register now',
          Keys.login.name: 'Log In',
        },
      };
}

enum Keys {
  none,
  password,
  loginTitle,
  email,
  doNotHaveAccount,
  registerNow,
  login
}
