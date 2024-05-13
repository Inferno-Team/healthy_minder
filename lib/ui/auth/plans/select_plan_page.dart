import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          child: SizedBox(
            height: size.height - 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(Keys.selectYourPlan.name.tr,
                      style: Get.textTheme.titleLarge),
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
                    child: MultiSelectDropDown<SelectTimeline>(
                      onOptionSelected: controller.onPlanSelect,
                      onOptionRemoved: controller.onPlanRemove,
                      controller: controller.planController,
                      hint: 'select your plan',
                      options: controller.plans,
                      selectionType: SelectionType.single,
                      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                      dropdownHeight: controller.plans.length > 6 ? 300 : 200,
                      optionTextStyle:
                          const TextStyle(fontSize: 16, color: Colors.black),
                      selectedOptionIcon: const Icon(Icons.check_circle),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: custemBtn(
                    textbtn: Keys.completeAccount.name.tr,
                    onPressed: controller.savePlan,
                    withIcon: false,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
