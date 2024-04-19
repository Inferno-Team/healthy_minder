import 'package:get/get.dart';

class LoginViewmodel extends GetxController {
  final _passwordObscureState = true.obs;

  bool get passwordState => _passwordObscureState.value;

  changePasswordState() =>
      _passwordObscureState.value = !_passwordObscureState.value;
}
