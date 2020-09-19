import 'dart:convert';

class User {
  User({
    this.name,
    this.dob,
    this.mobileNumber,
  });

  final String name;
  final DateTime dob;
  final int mobileNumber;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        dob: DateTime.parse(json["dob"]),
        mobileNumber: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dob": dob.toIso8601String(),
        "mobileNumber": mobileNumber,
      };
}
