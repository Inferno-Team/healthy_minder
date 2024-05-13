import 'package:healthy_minder/models/select_timeline.dart';

class SelectPlan {
  final String planName;
  final int planId;
  final List<SelectTimeline> timelines;

  SelectPlan(
      {required this.planName, required this.planId, required this.timelines});

  factory SelectPlan.fromJson(json) => SelectPlan(
        planId: json["plan_id"],
        planName: json["plan_name"],
        timelines: SelectTimeline.fromListJson(json["timelines"]),
      );

  static List<SelectPlan> fromListJson(json) =>
      (json as List).map((j) => SelectPlan.fromJson(j)).toList();
}
