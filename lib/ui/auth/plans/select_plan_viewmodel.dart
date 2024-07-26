import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/loading_status.dart';
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
  final _selectPlan = RxList<ValueItem<SelectPlan>>.empty();
  final _selectedPlans = <ValueItem<SelectPlan?>>[].obs;
  final _loadingPlansStatus = LoadingStatus.idle.obs;
  final _loadingSavePlanStatus = LoadingStatus.idle.obs;

  final _selectTimeline = RxList<ValueItem<SelectTimeline>>.empty();
  final _selectedTimeline = <ValueItem<SelectTimeline?>>[].obs;
  late MultiSelectController<SelectPlan> planController;
  late MultiSelectController<SelectTimeline> timelineController;

  List<ValueItem<SelectPlan>> get plans => _selectPlan;

  LoadingStatus get planStatus => _loadingPlansStatus.value;

  LoadingStatus get savePlanStatus => _loadingSavePlanStatus.value;

  List<ValueItem<SelectTimeline>> get timelines => _selectTimeline;

  List<ValueItem<SelectTimeline?>> get selectedTimelines => _selectedTimeline;

  SelectPlanViewmodel({required this.dataService});

  Future<void> _sendRequest() async {
    _loadingPlansStatus.value = LoadingStatus.started;
    String otherData = StorageHelper.getOtherData();
    String token = StorageHelper.getToken();
    planController = MultiSelectController();
    timelineController = MultiSelectController();
    Map<String, dynamic> data = json.decode(otherData);
    // List<int> goalIds = data['goals'];
    // List<int> diseaseIds = data['diseases'];
    _loadingPlansStatus.value = LoadingStatus.loading;
    ReturnType<List<SelectPlan>?>? response =
        await dataService.getPlanOfGoalsAndDiseases(token, data);
    _loadingPlansStatus.value = LoadingStatus.finished;
    if (response is ReturnDataType<List<SelectPlan>?>?) {
      _loadingPlansStatus.value = LoadingStatus.succeeded;
      List<SelectPlan> plans = response!.data!;
      for (SelectPlan plan in plans) {
        _selectPlan.add(
          ValueItem(
            label: plan.planName,
            value: plan,
          ),
        );
      }
    } else {
      _loadingPlansStatus.value = LoadingStatus.failed;
    }
  }

  @override
  void onInit() async {
    await _sendRequest();
    planController.setOptions(plans);
    _selectPlan.listen((plan) {});
    _selectedPlans.listen((values) {
      _selectTimeline.clear();
      if (values.isEmpty) {
        return;
      }
      SelectPlan plan = values.first.value!;
      List<SelectTimeline> planTimelines = plan.timelines;
      for (SelectTimeline selectTimeline in planTimelines) {
        print(selectTimeline.description);
        _selectTimeline.add(
          ValueItem(
            label: selectTimeline.name,
            value: selectTimeline,
          ),
        );
      }
    });
    super.onInit();
  }

  savePlan() async {
    _loadingSavePlanStatus.value = LoadingStatus.started;
    String token = StorageHelper.getToken();
    _loadingSavePlanStatus.value = LoadingStatus.loading;
    ReturnType? response = await dataService.selectPlanTimeline(
        token, _selectedTimeline.first.value!.id);
    Fluttertoast.showToast(msg: response!.msg.toString());
    if (response.code == 200) {
      StorageHelper.saveCurrentStep("home");
      Get.offAllNamed(HealthyRoutes.homePageRoute);
      _loadingSavePlanStatus.value = LoadingStatus.finished;
    } else {
      _loadingSavePlanStatus.value = LoadingStatus.failed;
    }
  }

  void onPlanRemove(int index, ValueItem<SelectPlan?> option) {
    _selectedPlans.remove(option);
  }

  void onPlanSelect(List<ValueItem<SelectPlan?>> selectedOptions) {
    _selectedPlans.clear();
    _selectedPlans.addAll(selectedOptions);
  }

  void onTimelineRemove(int index, ValueItem<SelectTimeline?> option) {
    _selectedTimeline.remove(option);
  }

  void onTimelineSelect(List<ValueItem<SelectTimeline?>> selectedOptions) {
    _selectedTimeline.clear();
    _selectedTimeline.addAll(selectedOptions);
  }

  Future<void> onRefresh() async {
    _selectedPlans.clear();
    _selectPlan.clear();
    _selectedTimeline.clear();
    await _sendRequest();
  }

  void goBack() async {
    StorageHelper.saveCurrentStep('login');
    String token = StorageHelper.getToken();
    StorageHelper.logout();
    // send request to remove this account.
    await dataService.removeMyAccount(token);
    // go back to login page.
    Get.offAllNamed(HealthyRoutes.loginRoute);
  }


}
