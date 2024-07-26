class SelectTimeline {
  final int id;
  final String name;
  final String coachName;
  final String? description;

  SelectTimeline({
    required this.id,
    required this.name,
    required this.coachName,
    required this.description,
  });

  factory SelectTimeline.fromJson(json) => SelectTimeline(
        id: json['id'],
        name: json['name'],
        coachName: json['coach_name'],
        description: json['description'],
      );

  static List<SelectTimeline> fromListJson(json) =>
      (json as List).map((j) => SelectTimeline.fromJson(j)).toList();
}
