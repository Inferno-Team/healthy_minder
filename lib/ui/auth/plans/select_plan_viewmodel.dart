import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/plan.dart';
import 'package:healthy_minder/models/return_types.dart';
import 'package:healthy_minder/models/select_plan.dart';
import 'package:healthy_minder/models/select_timeline.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/utils/constances.dart';
import 'package:healthy_minder/utils/storage_helper.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class SelectPlanViewmodel extends GetxController {
  final DataService dataService;
  final _selectPlan = RxList<ValueItem<SelectTimeline>>.empty();
  final _selectedPlans = <ValueItem<SelectTimeline?>>[].obs;

  late MultiSelectController<SelectTimeline> planController;

  List<ValueItem<SelectTimeline>> get plans => _selectPlan;

  SelectPlanViewmodel({required this.dataService});

  @override
  void onInit() async {
    String otherData = StorageHelper.getOtherData();
    String token = StorageHelper.getToken();
    planController = MultiSelectController();
    Map<String, dynamic> data = json.decode(otherData);
    // List<int> goalIds = data['goals'];
    // List<int> diseaseIds = data['diseases'];
    ReturnType<List<SelectPlan>?>? response =
        await dataService.getPlanOfGoalsAndDiseases(token, data);
    if (response is ReturnDataType<List<SelectPlan>?>?) {
      List<SelectPlan> plans = response!.data!;
      for (SelectPlan plan in plans) {
        for (SelectTimeline timeline in plan.timelines) {
          _selectPlan.add(
            ValueItem(
              label: "${plan.planName}-${timeline.coachName}",
              value: timeline,
            ),
          );
        }
      }
    }
    planController.setOptions(plans);
    super.onInit();
  }

  savePlan() async {
    String token = StorageHelper.getToken();
    ReturnType? response = await dataService.selectPlanTimeline(
        token, _selectedPlans.first.value!.id);
    Fluttertoast.showToast(msg: response!.msg.toString());
    StorageHelper.saveCurrentStep("home");
    Get.offAllNamed(HealthyRoutes.homePageRoute);
  }

  void onPlanRemove(int index, ValueItem<SelectTimeline?> option) {
    _selectedPlans.remove(option);
  }

  void onPlanSelect(List<ValueItem<SelectTimeline?>> selectedOptions) {
    _selectedPlans.clear();
    _selectedPlans.addAll(selectedOptions);
  }
}
