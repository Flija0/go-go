import 'dart:convert';

CarModelResp carModelRespFromJson(String str) => CarModelResp.fromJson(json.decode(str));

String carModelRespToJson(CarModelResp data) => json.encode(data.toJson());

class CarModelResp {
    final int id;
    final int power;
    final String brand;
    final String serialNumber;
    final String photo;
    final Owner owner;

    CarModelResp({
        required this.id,
        required this.power,
        required this.brand,
        required this.serialNumber,
        required this.photo,
        required this.owner,
    });

    factory CarModelResp.fromJson(Map<String, dynamic> json) => CarModelResp(
        id: json["id"],
        power: json["power"],
        brand: json["brand"],
        serialNumber: json["serialNumber"],
        photo: json["photo"],
        owner: Owner.fromJson(json["owner"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "power": power,
        "brand": brand,
        "serialNumber": serialNumber,
        "photo": photo,
        "owner": owner.toJson(),
    };
}

class Owner {
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

    Owner({
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

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
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
