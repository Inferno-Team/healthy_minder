import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/disease.dart';
import 'package:healthy_minder/models/get_goals_diseases_response.dart';
import 'package:healthy_minder/models/goal.dart';
import 'package:healthy_minder/models/loading_status.dart';
import 'package:healthy_minder/models/login_response_model.dart';
import 'package:healthy_minder/models/return_types.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:flutter/material.dart';

class SignupViewmodel extends GetxController {
  final DataService dataService;
  SignupViewmodel({required this.dataService});

  final _diseases = RxList<ValueItem<Disease>>.empty();
  final _goals = RxList<ValueItem<Goal>>.empty();
  final _signUpLoadingStatus = LoadingStatus.idle.obs;
  final _selectedDiseases = [].obs;
  final _selectedGoals = [].obs;
  final _passwordObscureState = true.obs;
  final _genderState = 'Male'.obs;
  final _firstNameContainer = "".obs;
  final _lastNameContainer = "".obs;
  final _emailContainer = "".obs;
  final _passwordContainer = "".obs;
  final _weightContainer = "".obs;
  final _heightContainer = "".obs;

  final _firstNameErrorContainer = Rxn<String>();
  final _lastNameErrorContainer = Rxn<String>();
  final _emailErrorContainer = Rxn<String>();
  final _passwordErrorContainer = Rxn<String>();

  final _birthDateErrorContainer = Rxn<String>();
  final _weightErrorContainer = Rxn<String>();
  final _heightErrorContainer = Rxn<String>();


  String get gender => _genderState.value;

  late final TextEditingController dobTextController;

  String? get firstNameError => _firstNameErrorContainer.value;

  String? get lastNameError => _lastNameErrorContainer.value;

  String? get emailError => _emailErrorContainer.value;

  String? get passwordError => _passwordErrorContainer.value;

  String? get birthDateError => _birthDateErrorContainer.value;

  String? get weightError => _weightErrorContainer.value;

  String? get heightError => _heightErrorContainer.value;

  LoadingStatus get signUpStatus =>_signUpLoadingStatus.value;

  changeGender(String gender) => _genderState.value = gender;
  final Rx<DateTime> _selectedDate = DateTime(1999).obs;

  String get dob => _selectedDate.value.toString();

  bool get passwordState => _passwordObscureState.value;

  changePasswordState() =>
      _passwordObscureState.value = !_passwordObscureState.value;

  List<ValueItem<Disease>> get diseases => _diseases;

  List<ValueItem<Goal>> get goals => _goals;

  void onDiseaseSelect(List<ValueItem<Disease>> diseases) {
    _selectedDiseases.clear();
    _selectedDiseases.addAll(diseases);
  }

  void onDiseaseRemove(int pos, ValueItem<Disease> disease) =>
      _selectedDiseases.remove(disease);

  void onGoalSelect(List<ValueItem<Goal>> goals) {
    _selectedGoals.clear();
    _selectedGoals.addAll(goals);
  }

  void onGoalRemove(int pos, ValueItem<Goal> goal) =>
      _selectedGoals.remove(goal);

  @override
  void onInit() async {
    dobTextController = TextEditingController();
    ReturnType<GetGoalsAndDiseasesResponse?>? getResponse =
        await dataService.getGoalsAndDiseasesResponse();
    if (getResponse is ReturnDataType<GetGoalsAndDiseasesResponse?>) {
      List<Goal> goals = (getResponse).data!.goals;
      List<Disease> diseases = (getResponse).data!.diseases;
      for (Goal goal in goals) {
        _goals.add(
          ValueItem(label: goal.name, value: goal),
        );
      }
      for (Disease disease in diseases) {
        _diseases.add(ValueItem(
          label: disease.name,
          value: disease,
        ));
      }
    }
    /* for (int i = 0; i < 5; i++) {
      Disease disease = Disease(id: i + 1, name: "Disease ${i + 1}");
      Goal goal = Goal(id: i + 1, name: "Goal ${i + 1}");
      _diseases.add(
        ValueItem(
          label: disease.name,
          value: disease,
        ),
      );
      _goals.add(
        ValueItem(label: goal.name, value: goal),
      );
    }*/
    super.onInit();
  }

  Future<void> showDatePickerWidget(BuildContext context) async {
    clearBirthDateValidation();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate.value,
      firstDate: DateTime(1950),
      lastDate: DateTime(2005),
    );
    if (picked != null && picked != _selectedDate.value) {
      _selectedDate.value = picked;
      dobTextController.text = _formatDate(picked);
    }
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.year}/${_addLeadingZero(dateTime.month)}/${_addLeadingZero(dateTime.day)}';
  }

  // Function to add leading zero if needed
  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }

  preformSignup() async {
    final diseases =
        _selectedDiseases.map((element) => element.value?.id).toList();
    final goals = _selectedGoals.map((element) => element.value?.id).toList();
    //validate diseases and goals is selected.
    bool validated = _validateDiseasesAndGoals(diseases, goals);
    if (!validated) return;
    _signUpLoadingStatus.value = LoadingStatus.started;
    // prepare data to send .
    String firstname = _firstNameContainer.value;
    String lastname = _lastNameContainer.value;
    String email = _emailContainer.value;
    String password = _passwordContainer.value;
    String dob = _selectedDate.value.millisecondsSinceEpoch.toString();
    String weight = _weightContainer.value;
    String height = _heightContainer.value;
    String gender = _genderState.value;

    Map<String, dynamic> sendData = {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "password": password,
      "dob": dob,
      "weight": weight,
      "height": height,
      "gender": gender.toLowerCase(),
    };
    _signUpLoadingStatus.value = LoadingStatus.loading;
    ReturnType<LoginResponse?>? response = await dataService.register(sendData);
    _signUpLoadingStatus.value = LoadingStatus.finished;
    if (response == null) {
      _signUpLoadingStatus.value = LoadingStatus.failed;
      Fluttertoast.showToast(
          msg: "something went wrong please try again later.");
      return;
    }
    if (response is ReturnError<LoginResponse?>) {
      _signUpLoadingStatus.value = LoadingStatus.failed;
      List<Error> errors = (response).errors;
      print(errors);
      return;
    }
    if (response is ReturnDataType<LoginResponse?>) {
      _signUpLoadingStatus.value = LoadingStatus.succeeded;
      LoginResponse register = response.data!;
      StorageHelper.login(register.token);
      StorageHelper.saveUser(register.user);
      StorageHelper.saveOtherData(
        json.encode({
          "goals": goals,
          "diseases": diseases,
        }),
      );
      StorageHelper.saveCurrentStep("register");
      Get.offAllNamed(HealthyRoutes.selectPlanRoute);
    }
  }

  firstNameChanged(String? value) => _firstNameContainer.value = value ?? "";

  lastNameChanged(String? value) => _lastNameContainer.value = value ?? "";

  emailChanged(String? value) => _emailContainer.value = value ?? "";

  passwordChanged(String? value) => _passwordContainer.value = value ?? "";

  weightChanged(String? value) => _weightContainer.value = value ?? "";

  heightChanged(String? value) => _heightContainer.value = value ?? "";

  void validateFirstPage() {
    clearFirstNameValidation();
    clearLastNameValidation();
    clearEmailValidation();
    clearPasswordValidation();
    bool validated = true;
    if (_firstNameContainer.value.isEmpty) {
      _firstNameErrorContainer.value = "Must not be empty.";
      validated = false;
    }
    if (_lastNameContainer.value.isEmpty) {
      _lastNameErrorContainer.value = "Must not be empty.";
      validated = false;
    }
    if (_emailContainer.value.isEmpty) {
      _emailErrorContainer.value = "Must not be empty.";
      validated = false;
    }
    if (!_isValidEmail()) {
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

    if (!validated) return;
    Get.toNamed(HealthyRoutes.secondSignupRoute);
  }

  void clearFirstNameValidation() {
    _firstNameErrorContainer.value = null;
  }

  void clearLastNameValidation() {
    _lastNameErrorContainer.value = null;
  }

  void clearEmailValidation() {
    _emailErrorContainer.value = null;
  }

  void clearPasswordValidation() {
    _passwordErrorContainer.value = null;
  }

  bool _isValidEmail() {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)'
            r'|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])'
            r'|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(_emailContainer.value);
  }

  void validateSecondPage() {
    clearBirthDateValidation();
    clearWeightValidation();
    clearHeightValidation();
    bool validated = true;
    if (dobTextController.text.isEmpty) {
      _birthDateErrorContainer.value = "Must not be empty.";
      validated = false;
    }
    if (_weightContainer.value.isEmpty) {
      _weightErrorContainer.value = "Must not be empty.";
      validated = false;
    }
    if (_heightContainer.value.isEmpty) {
      _heightErrorContainer.value = "Must not be empty.";
      validated = false;
    }

    if (!validated) return;
    Get.toNamed(HealthyRoutes.finalSignupRoute);
  }

  void clearBirthDateValidation() {
    _birthDateErrorContainer.value = null;
  }

  void clearWeightValidation() {
    _weightErrorContainer.value = null;
  }

  void clearHeightValidation() {
    _heightErrorContainer.value = null;
  }

  bool _validateDiseasesAndGoals(List diseases, List goals) {
    String msg = "you must select at least one";
    if (diseases.isEmpty) {
      msg += " disease";
    }
    if (goals.isEmpty) {
      if(diseases.isEmpty){
        msg += " and one goal";
      }else{
        msg += " goal";
      }

    }
    if (diseases.isEmpty || goals.isEmpty) {
      Fluttertoast.showToast(msg: msg,toastLength: Toast.LENGTH_LONG);
    }

    return diseases.isNotEmpty && goals.isNotEmpty;
  }
}
