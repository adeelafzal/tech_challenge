import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    required this.email,
    required this.password,
    required this.interest,
    required this.watchCount,
  });

  String email;
  String password;
  List<String> interest;
  int watchCount;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    email: json["email"],
    password: json["password"],
    interest: List<String>.from(json["interest"].map((x) => x)),
    watchCount: json["watchCount"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "interest": List<dynamic>.from(interest.map((x) => x)),
    "watchCount": watchCount,
  };
}
