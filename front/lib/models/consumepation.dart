import 'dart:convert';

List<ConsumptionModel> consumptionModelFromJson(String str) => List<ConsumptionModel>.from(json.decode(str).map((x) => ConsumptionModel.fromJson(x)));

String consumptionModelToJson(List<ConsumptionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConsumptionModel {
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

  ConsumptionModel({
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

  factory ConsumptionModel.fromJson(Map<String, dynamic> json) => ConsumptionModel(
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
