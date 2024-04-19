class Disease {
  final int id;
  final String name;

  Disease({
    required this.id,
    required this.name,
  });

  factory Disease.fromJson(dynamic json) => Disease(
        id: json['id'] ?? -1,
        name: json['name'] ?? '',
      );

  factory Disease.empty() => Disease(
        id: -1,
        name: '',
      );
}
