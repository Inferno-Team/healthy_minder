class PremiumStatus {
  final String status;

  PremiumStatus({required this.status});

  factory PremiumStatus.fromJson(Map<String, dynamic> json) =>
      PremiumStatus(status: json['status'] ?? "");

  factory PremiumStatus.fromValue(value) => PremiumStatus(status: value);

  factory PremiumStatus.empty() => PremiumStatus(status: "");
}
