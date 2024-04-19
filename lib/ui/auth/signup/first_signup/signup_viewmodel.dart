import 'package:get/get.dart';
// import 'package:healthy_minder/utils/storage_helper.dart';

class SignupViewModel extends GetxController {
  final _passwordObscureState = true.obs;

  bool get passwordState => _passwordObscureState.value;

  changePasswordState() =>
      _passwordObscureState.value = !_passwordObscureState.value;
}
