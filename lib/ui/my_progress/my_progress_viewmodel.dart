import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/loading_status.dart';
import 'package:healthy_minder/models/return_types.dart';
import 'package:healthy_minder/models/timeline_event.dart';
import 'package:healthy_minder/repositories/data_service.dart';
import 'package:healthy_minder/utils/storage_helper.dart';

class MyProgressViewModel extends GetxController {
  final DataService dataService;
  final _loadingStatus = LoadingStatus.started.obs;
  final events = RxList<TimelineEvent>.empty();

  LoadingStatus get loadingStatus => _loadingStatus.value;

  MyProgressViewModel({required this.dataService});

  @override
  void onInit() async {
    String token = StorageHelper.getToken();
    dataService.getTimelineWithMyProgress(token).then((value) {
      _loadingStatus.value = LoadingStatus.finished;
      if (value is ReturnDataType<List<TimelineEvent>?>) {
        events.value = value.data!;
        _loadingStatus.value = LoadingStatus.succeeded;
      } else {
        _loadingStatus.value = LoadingStatus.failed;
      }
    });
    super.onInit();
  }

  void addNewProgress() {
    final _events = events
        .map((element) => DropdownMenuEntry<TimelineEvent>(
              label: element.eventItem.name,
              value: element,
            ))
        .toList();
    var sliderValue = 0.0.obs;
    var _selectedItem = TimelineEvent.empty().obs;
    _selectedItem.listen((p0) {
      sliderValue.value = p0.progress.toDouble();
    });
    final size = MediaQuery.of(Get.context!).size;
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          height: 220,
          width: size.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 16),
                child: Text(
                  "Add New Timeline Event Progress",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              DropdownMenu<TimelineEvent>(
                width: size.width * 0.66,
                dropdownMenuEntries: _events,
                hintText: "Select Timeline Event",
                onSelected: (selectedItem) =>
                    _selectedItem.value = selectedItem ?? TimelineEvent.empty(),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Column(
                  children: [
                    Slider(
                      max: 100,
                      divisions: 5,
                      min: 0,
                      label: "value : ${sliderValue.value}",
                      onChanged: (value) => sliderValue.value = value,
                      value: sliderValue.value,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "0",
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            "100",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel', style: Get.textTheme.displaySmall),
          ),
          TextButton(
            onPressed: () {
              String token = StorageHelper.getToken();
              _loadingStatus.value = LoadingStatus.loading;
              dataService
                  .sendNewProgress(
                      token, _selectedItem.value.id, sliderValue.value)
                  .then((value) {
                _loadingStatus.value = LoadingStatus.finished;
                if (value is ReturnDataType<TimelineEvent?>) {
                  int index = events.indexWhere(
                      (element) => element.id == _selectedItem.value.id);
                  events[index] = value.data!;
                  _loadingStatus.value = LoadingStatus.succeeded;
                } else {
                  _loadingStatus.value = LoadingStatus.failed;
                }
                //do something to refresh the data.
              });
              Get.back();
            },
            child: Text('Add', style: Get.textTheme.displaySmall),
          ),
        ],
      ),
    );
  }
}

