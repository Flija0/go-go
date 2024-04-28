import 'dart:convert';

DemandeReq demandeReqFromJson(String str) => DemandeReq.fromJson(json.decode(str));

String demandeReqToJson(DemandeReq data) => json.encode(data.toJson());

class DemandeReq {
  final int id;
  final String status;
  final User user;
  final Ride ride;

  DemandeReq({
    required this.id,
    required this.status,
    required this.user,
    required this.ride,
  });

  factory DemandeReq.fromJson(Map<String, dynamic> json) => DemandeReq(
    id: json["id"],
    status: json["status"],
    user: User.fromJson(json["user"]),
    ride: Ride.fromJson(json["ride"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "user": user.toJson(),
    "ride": ride.toJson(),
  };
}

class Ride {
  final int id;
  final String startLocation;
  final String finalDestination;
  final int numberOfSeats;
  final String goingOffTime;
  final bool femaleOnly;
  final int consumption;
  final DateTime dateCreated;
  final User creator;
  final String day;

  Ride({
    required this.id,
    required this.startLocation,
    required this.finalDestination,
    required this.numberOfSeats,
    required this.goingOffTime,
    required this.femaleOnly,
    required this.consumption,
    required this.dateCreated,
    required this.creator,
    required this.day,
  });

  factory Ride.fromJson(Map<String, dynamic> json) => Ride(
    id: json["id"],
    startLocation: json["startLocation"],
    finalDestination: json["finalDestination"],
    numberOfSeats: json["numberOfSeats"],
    goingOffTime: json["goingOffTime"],
    femaleOnly: json["femaleOnly"],
    consumption: json["consumption"],
    dateCreated: DateTime.parse(json["dateCreated"]),
    creator: User.fromJson(json["creator"]),
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
    "dateCreated": dateCreated.toIso8601String(),
    "creator": creator.toJson(),
    "day": day,
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
