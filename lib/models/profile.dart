class Profile {
  final String fullName;
  final String email;
  final String weight;
  final String height;
  final String dob;
  final String coach;
  final String timelineName;
  final String userName;
  final String firstName;
  final String lastName;
  final int eventCount;
  String? avatar;

  Profile(
      {required this.fullName,
      required this.email,
      required this.weight,
      required this.dob,
      required this.coach,
      required this.timelineName,
      required this.userName,
      required this.firstName,
      required this.lastName,
      required this.eventCount,
      required this.height,
      this.avatar});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        fullName: json['fullname'],
        email: json['email'],
        weight: json['weight'],
        dob: json['dob'],
        coach: json['coach'],
        userName: json['username'],
        timelineName: json['timeline'],
        firstName: json['firstname'],
        lastName: json['lastname'],
        eventCount: json['event_count'],
        height: json['height'],
        avatar: json['avatar'],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullName,
        "dob": dob,
        "email": email,
        "weight": weight,
        "firstname": firstName,
        "coach": coach,
        "lastname": lastName,
        "timeline": timelineName,
        "username": userName,
        "event_count": eventCount,
        "height": height,
        "avatar": avatar,
      };

  factory Profile.empty() => Profile(
        fullName: "",
        dob: "",
        email: "",
        weight: "",
        firstName: "",
        coach: "",
        lastName: "",
        timelineName: "",
        userName: "",
        eventCount: 0,
        height: "0",
        avatar: null,
      );
}
