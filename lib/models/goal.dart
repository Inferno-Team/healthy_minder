class Goal {
  final int id;
  final String name;

  Goal({required this.id, required this.name});

  factory Goal.fromJson(dynamic json) =>
      Goal(id: json['id'] ?? -1, name: json['name'] ?? '');

  factory Goal.empty() => Goal(id: -1, name: '');
}
