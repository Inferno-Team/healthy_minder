class Plan {
  final int id;
  final String name;

  Plan({required this.id, required this.name});

  factory Plan.fromJson(json) => Plan(id: json['id'], name: json['name']);

  factory Plan.empty() => Plan(id: -1, name: "empty");
}
