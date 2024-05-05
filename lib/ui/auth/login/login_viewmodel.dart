import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

  void setPassword(String? password) =>
      _passwordContainer.value = password ?? "";

  void setEmail(String? email) => _emailContainer.value = email ?? "";

  bool get passwordState => _passwordObscureState.value;

  changePasswordState() =>
      _passwordObscureState.value = !_passwordObscureState.value;

  void login() async {
    String email = _emailContainer.value;
    String password = _passwordContainer.value;
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Email and password must not be empty.");
      return;
    }
    ReturnType<LoginResponse?>? response =
        await dataService.login(email, password);
    if (response == null) {
      Fluttertoast.showToast(
          msg: "something went wrong please try again later.");
      return;
    }
    if (response is ReturnDataType) {
      LoginResponse? loginResponse =
          (response as ReturnDataType<LoginResponse?>).data;
      if (loginResponse == null) {
        Fluttertoast.showToast(
            msg: "something went wrong please try again later");
        return;
      }
      String token = loginResponse.token;
      SavedUser user = loginResponse.user;
      StorageHelper.login(token);
      StorageHelper.saveUser(user);
      Fluttertoast.showToast(msg: "Logged in successfully.");
      Get.offAllNamed(HealthyRoutes.homePageRoute);
    }
  }
}
