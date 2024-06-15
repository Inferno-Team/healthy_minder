import 'package:get/get.dart';

class PremiumStatus {
  PremiumStatusTypes status;

  PremiumStatus({required this.status});

  factory PremiumStatus.fromJson(Map<String, dynamic> json) => PremiumStatus(
      status: PremiumStatusTypes.values
              .firstWhereOrNull((element) => element.name == json['status']) ??
          PremiumStatusTypes.unknown);

  factory PremiumStatus.fromValue(value) => PremiumStatus(
      status: PremiumStatusTypes.values
              .firstWhereOrNull((element) => element.name == value) ??
          PremiumStatusTypes.unknown);

  factory PremiumStatus.empty() =>
      PremiumStatus(status: PremiumStatusTypes.unknown);
}

enum PremiumStatusTypes {
  approved("approved"),
  declined("declined"),
  pending("pending"),
  unknown("");

  final String _text;

  const PremiumStatusTypes(this._text);
}
