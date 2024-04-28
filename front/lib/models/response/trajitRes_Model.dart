import 'dart:convert';

TrajitModelRes trajitModelResFromJson(String str) => TrajitModelRes.fromJson(json.decode(str));

String trajitModelResToJson(TrajitModelRes data) => json.encode(data.toJson());

class TrajitModelRes {
  final int id;
  final String startLocation;
  final String finalDestination;
  final int numberOfSeats;
  final String goingOffTime;
  final bool femaleOnly;
  final int consumption;
  final Creator creator;
  final String day;

  TrajitModelRes({
    required this.id,
    required this.startLocation,
    required this.finalDestination,
    required this.numberOfSeats,
    required this.goingOffTime,
    required this.femaleOnly,
    required this.consumption,
    required this.creator,
    required this.day,
  });

  factory TrajitModelRes.fromJson(Map<String, dynamic> json) => TrajitModelRes(
    id: json["id"],
    startLocation: json["startLocation"],
    finalDestination: json["finalDestination"],
    numberOfSeats: json["numberOfSeats"],
    goingOffTime: json["goingOffTime"],
    femaleOnly: json["femaleOnly"],
    consumption: json["consumption"],
    creator: Creator.fromJson(json["creator"]),
    day: json["day"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "startLocation": startLocation,
    "finalDestination": finalDestination,
    "numberOfSeats": numberOfSeats,
    "goingOffTime": goingOffTime,
    "femaleOnly": femaleOnly,
    "consumption": consumption,
    "creator": creator.toJson(),
    "day": day,
  };
}

class Creator {
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

  Creator({
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

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
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