import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoViewModel extends GetxController {
  final _genderState = 'Meal'.obs;

  String get gender => _genderState.value;

  late final TextEditingController dobTextController;

  changeGender(String gender) => _genderState.value = gender;
  final Rx<DateTime> _selectedDate = DateTime(1999).obs;

  String get dob => _selectedDate.value.toString();

  @override
  void onInit() {
    dobTextController = TextEditingController();
    super.onInit();
  }

  Future<void> showDatePickerWidget(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate.value,
      firstDate: DateTime(1950),
      lastDate: DateTime(2005),
    );
    if (picked != null && picked != _selectedDate.value) {
      _selectedDate.value = picked;
      dobTextController.text = _formatDate(picked);
      update(["dob-widget"]);
    }
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.year}/${_addLeadingZero(dateTime.month)}/${_addLeadingZero(dateTime.day)}';
  }

  // Function to add leading zero if needed
  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }
}
