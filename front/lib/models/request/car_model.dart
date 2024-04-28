import 'dart:convert';

CarModelReq carModelReqFromJson(String str) => CarModelReq.fromJson(json.decode(str));

String carModelReqToJson(CarModelReq data) => json.encode(data.toJson());

class CarModelReq {
  final int power;
  final String brand;
  final String serialNumber;
  final String photo;

  CarModelReq({
    required this.power,
    required this.brand,
    required this.serialNumber,
    required this.photo,
  });

  factory CarModelReq.fromJson(Map<String, dynamic> json) => CarModelReq(
    power: json["power"],
    brand: json["brand"],
    serialNumber: json["serialNumber"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "power": power,
    "brand": brand,
    "serialNumber": serialNumber,
    "photo": photo,
  };
}
