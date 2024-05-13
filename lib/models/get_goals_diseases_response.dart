import 'package:healthy_minder/models/disease.dart';
import 'package:healthy_minder/models/goal.dart';

class GetGoalsAndDiseasesResponse {
  final List<Goal> goals;
  final List<Disease> diseases;

  GetGoalsAndDiseasesResponse({required this.goals, required this.diseases});

  factory GetGoalsAndDiseasesResponse.fromJson(json) =>
      GetGoalsAndDiseasesResponse(
        diseases:
            (json['diseases'] as List).map((e) => Disease.fromJson(e)).toList(),
        goals: (json['goals'] as List).map((e) => Goal.fromJson(e)).toList(),
      );
}
