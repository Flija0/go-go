
import 'dart:convert';

LoginModelReq loginModelReqFromJson(String str) => LoginModelReq.fromJson(json.decode(str));

String loginModelReqToJson(LoginModelReq data) => json.encode(data.toJson());

class LoginModelReq {
    final String email;
    final String mdp;

    LoginModelReq({
        required this.email,
        required this.mdp,
    });

    factory LoginModelReq.fromJson(Map<String, dynamic> json) => LoginModelReq(
        email: json["email"],
        mdp: json["mdp"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "mdp": mdp,
    };
}
