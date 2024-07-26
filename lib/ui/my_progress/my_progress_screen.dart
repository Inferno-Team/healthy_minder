import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/models/loading_status.dart';
import 'package:healthy_minder/ui/custom/custom_event_widget.dart';
import 'package:healthy_minder/ui/my_progress/my_progress_viewmodel.dart';
import 'package:healthy_minder/utils/translator.dart';

class MyProgressScreen extends GetView<MyProgressViewModel> {
  const MyProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => [LoadingStatus.started,LoadingStatus.loading].contains(controller.loadingStatus)
          ? Center(
              child: CircularProgressIndicator(
                color: Get.theme.primaryColor,
              ),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 24, left: 20, right: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Your Progress",
                              style: Get.textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height,
                          child: ListView.builder(
                            itemBuilder: (_, int index) => EventWidget(
                              event: controller.events[index],
                            ),
                            itemCount: controller.events.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    backgroundColor: Get.theme.primaryColor,
                    onPressed:controller.addNewProgress,
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
