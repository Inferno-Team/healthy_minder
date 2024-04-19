import 'package:get/get.dart';
import 'package:healthy_minder/models/disease.dart';
import 'package:healthy_minder/models/goal.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'package:multi_dropdown/models/value_item.dart';

class ThirtSignupViewModel extends GetxController {
  final _diseases = RxList<ValueItem<Disease>>.empty();
  final _goals = RxList<ValueItem<Goal>>.empty();
  final _selectedDiseases = [].obs;
  final _selectedGoals = [].obs;

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
  void onInit() {
    for (int i = 0; i < 5; i++) {
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
    }
    super.onInit();
  }
}
