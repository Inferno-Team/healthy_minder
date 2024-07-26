import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthy_minder/models/loading_status.dart';
import 'package:healthy_minder/models/login_response_model.dart';
import 'package:healthy_minder/models/return_types.dart';
import 'package:healthy_minder/models/saved_user.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class LoginViewmodel extends GetxController {
  final DataService dataService;

  LoginViewmodel({required this.dataService});

  final _passwordObscureState = true.obs;
  final _emailContainer = "".obs;
  final _passwordContainer = "".obs;
  final _loginStatus = LoadingStatus.idle.obs;

  LoadingStatus get loginStatus => _loginStatus.value;

  final _emailErrorContainer = Rxn<String>();
  final _passwordErrorContainer = Rxn<String>();

  String? get passwordError => _passwordErrorContainer.value;

  String? get emailError => _emailErrorContainer.value;

  void setPassword(String? password) =>
      _passwordContainer.value = password ?? "";

  void setEmail(String? email) => _emailContainer.value = email ?? "";

  bool get passwordState => _passwordObscureState.value;

  changePasswordState() =>
      _passwordObscureState.value = !_passwordObscureState.value;

  void login() async {
    bool validated = _validateEmailAndPassword();
    if (!validated) return;
    _loginStatus.value = LoadingStatus.started;
    String email = _emailContainer.value;
    String password = _passwordContainer.value;
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Email and password must not be empty.");
      _loginStatus.value = LoadingStatus.failed;
      return;
    }
    _loginStatus.value = LoadingStatus.loading;
    ReturnType<LoginResponse?>? response =
        await dataService.login(email, password);
    if (response == null) {
      Fluttertoast.showToast(
          msg: "something went wrong please try again later.");
      _loginStatus.value = LoadingStatus.failed;
      return;
    }
    if (response is ReturnDataType) {
      LoginResponse? loginResponse =
          (response as ReturnDataType<LoginResponse?>).data;
      if (loginResponse == null) {
        Fluttertoast.showToast(
            msg: "something went wrong please try again later");
        _loginStatus.value = LoadingStatus.failed;
        return;
      }
      String token = loginResponse.token;
      SavedUser user = loginResponse.user;
      StorageHelper.login(token);
      StorageHelper.saveUser(user);
      Fluttertoast.showToast(msg: "Logged in successfully.");
      _loginStatus.value = LoadingStatus.finished;
      Get.offAllNamed(HealthyRoutes.homePageRoute);
    } else {
      String message = response.msg;
      Fluttertoast.showToast(msg: message);
      _loginStatus.value = LoadingStatus.finished;
    }
  }

  void clearPasswordValidation() {
    _passwordErrorContainer.value = null;
  }

  void clearEmailValidation() {
    _emailErrorContainer.value = null;
  }

  bool _validateEmailAndPassword() {
    clearEmailValidation();
    clearPasswordValidation();
    bool validated = true;
    if (_emailContainer.value.isEmpty) {
      _emailErrorContainer.value = "Must not be empty.";
      validated = false;
    }
    if (_emailContainer.value.isNotEmpty && !_isValidEmail()) {
      _emailErrorContainer.value = "Must be email.";
      validated = false;
    }
    if (_passwordContainer.value.isEmpty) {
      _passwordErrorContainer.value = "Must not be empty.";
      validated = false;
    }
    if (_passwordContainer.value.isNotEmpty &&
        _passwordContainer.value.length < 8) {
      _passwordErrorContainer.value = "Must not be less then 8 characters.";
      validated = false;
    }
    return validated;
  }

  bool _isValidEmail() {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)'
            r'|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])'
            r'|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(_emailContainer.value);
  }
}
