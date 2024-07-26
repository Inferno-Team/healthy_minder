import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/loading_status.dart';
import 'package:healthy_minder/models/plan.dart';
import 'package:healthy_minder/models/select_plan.dart';
import 'package:healthy_minder/models/select_timeline.dart';
import 'package:healthy_minder/ui/auth/plans/select_plan_viewmodel.dart';
import 'package:healthy_minder/ui/custom/custem_button.dart';
import 'package:healthy_minder/utils/translator.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class SelectPlanPage extends GetView<SelectPlanViewmodel> {
  const SelectPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 249, 250, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Obx(
            () => SizedBox(
              height: size.height - 40,
              child: RefreshIndicator(
                onRefresh: controller.onRefresh,
                child: [
                  LoadingStatus.loading,
                  LoadingStatus.started,
                ].contains(controller.planStatus)
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(251, 99, 64, 1),
                        ),
                      )
                    : controller.plans.isEmpty
                        ? ListView(
                            children: [
                              SizedBox(
                                height: size.height * 0.4,
                              ),
                              const Text(
                                "No Plans For your selected goals and diseases.",
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.2,
                                  vertical: 32,
                                ),
                                child: CustomButton(
                                  text: "logout",
                                  withIcon: false,
                                  onPressed:controller.goBack,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.3,
                              ),
                            ],
                          )
                        : ListView(
                            children: [
                              SizedBox(
                                height: size.height - 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: controller.goBack,
                                          child: FaIcon(
                                            FontAwesomeIcons.arrowLeft,
                                            color: Get.theme.primaryColor,
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            Keys.selectYourPlan.name.tr,
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  52, 71, 103, 1),
                                              fontSize: 30,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(Keys.selectPlanTitle.name.tr,
                                          style: Get.textTheme.titleMedium),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 20),
                                    ),
                                    Obx(
                                      () => Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: MultiSelectDropDown<SelectPlan>(
                                          onOptionSelected:
                                              controller.onPlanSelect,
                                          onOptionRemoved:
                                              controller.onPlanRemove,
                                          controller: controller.planController,
                                          hint: 'select your plan',
                                          options: controller.plans,
                                          selectionType: SelectionType.single,
                                          chipConfig: const ChipConfig(
                                              wrapType: WrapType.wrap),
                                          dropdownHeight:
                                              controller.plans.length > 6
                                                  ? 300
                                                  : 200,
                                          optionTextStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                          selectedOptionIcon:
                                              const Icon(Icons.check_circle),
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: controller.timelines.isEmpty
                                            ? Container()
                                            : Column(
                                                children: [
                                                  MultiSelectDropDown<
                                                      SelectTimeline>(
                                                    onOptionSelected: controller
                                                        .onTimelineSelect,
                                                    onOptionRemoved: controller
                                                        .onTimelineRemove,
                                                    controller: controller
                                                        .timelineController,
                                                    hint:
                                                        'select your timeline',
                                                    options:
                                                        controller.timelines,
                                                    selectionType:
                                                        SelectionType.single,
                                                    chipConfig:
                                                        const ChipConfig(
                                                            wrapType:
                                                                WrapType.wrap),
                                                    dropdownHeight: controller
                                                                .plans.length >
                                                            6
                                                        ? 300
                                                        : 200,
                                                    optionTextStyle:
                                                        const TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black),
                                                    selectedOptionIcon:
                                                        const Icon(
                                                            Icons.check_circle),
                                                  ),
                                                  controller.selectedTimelines
                                                          .isNotEmpty
                                                      ? CustomTimelineDescription(
                                                          timeline: controller
                                                              .selectedTimelines
                                                              .first
                                                              .value,
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: CustomButton(
                                        text: Keys.completeAccount.name.tr,
                                        onPressed: controller.savePlan,
                                        withIcon: false,
                                        status: controller.savePlanStatus,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTimelineDescription extends StatelessWidget {
  final SelectTimeline? timeline;

  const CustomTimelineDescription({
    super.key,
    required this.timeline,
  });

  @override
  Widget build(BuildContext context) {
    if (timeline == null) {
      return Container();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Timeline Details: ",
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Coach Name: ",
                style: Get.textTheme.bodyLarge,
              ),
              Text(
                timeline!.coachName,
                style: Get.textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description: ",
                style: Get.textTheme.bodyLarge,
              ),
              Expanded(
                child: Text(
                  timeline!.description ?? "",
                  style: Get.textTheme.bodySmall,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
}
