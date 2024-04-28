import 'dart:convert';

List<Convertation> convertationFromJson(String str) => List<Convertation>.from(json.decode(str).map((x) => Convertation.fromJson(x)));

String convertationToJson(List<Convertation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Convertation {
  final int id;
  final DateTime createdAt;
  final User firstUser;
  final User secondUser;

  Convertation({
    required this.id,
    required this.createdAt,
    required this.firstUser,
    required this.secondUser,
  });

  factory Convertation.fromJson(Map<String, dynamic> json) => Convertation(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    firstUser: User.fromJson(json["firstUser"]),
    secondUser: User.fromJson(json["secondUser"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "firstUser": firstUser.toJson(),
    "secondUser": secondUser.toJson(),
  };
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String mdp;
  final int phone;
  final String gender;
  final int consumptionExpected;
  final bool active;
  final int verified;
  final DateTime dateCompte;
  final int role;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mdp,
    required this.phone,
    required this.gender,
    required this.consumptionExpected,
    required this.active,
    required this.verified,
    required this.dateCompte,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    mdp: json["mdp"],
    phone: json["phone"],
    gender: json["gender"],
    consumptionExpected: json["consumptionExpected"],
    active: json["active"],
    verified: json["verified"],
    dateCompte: DateTime.parse(json["dateCompte"]),
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "mdp": mdp,
    "phone": phone,
    "gender": gender,
    "consumptionExpected": consumptionExpected,
    "active": active,
    "verified": verified,
    "dateCompte": "${dateCompte.year.toString().padLeft(4, '0')}-${dateCompte.month.toString().padLeft(2, '0')}-${dateCompte.day.toString().padLeft(2, '0')}",
    "role": role,
  };
}
