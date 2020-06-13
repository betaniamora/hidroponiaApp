// To parse this JSON data, do
//
//     final datosModel = datosModelFromJson(jsonString);

import 'dart:convert';

DatosModel datosModelFromJson(String str) => DatosModel.fromJson(json.decode(str));

String datosModelToJson(DatosModel data) => json.encode(data.toJson());

class DatosModel {
    String code;
    bool message;
    Data data;

    DatosModel({
        this.code,
        this.message,
        this.data,
    });

    factory DatosModel.fromJson(Map<String, dynamic> json) => DatosModel(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    User user;
    List<Inve> inve;

    Data({
        this.user,
        this.inve,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["USER"]),
        inve: List<Inve>.from(json["INVE"].map((x) => Inve.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "USER": user.toJson(),
        "INVE": List<dynamic>.from(inve.map((x) => x.toJson())),
    };
}

class Inve {
    int inveCodi;
    String inveDesc;
    List<Modulo> modulo;

    Inve({
        this.inveCodi,
        this.inveDesc,
        this.modulo,
    });

    factory Inve.fromJson(Map<String, dynamic> json) => Inve(
        inveCodi: json["INVE_CODI"],
        inveDesc: json["INVE_DESC"],
        modulo: List<Modulo>.from(json["MODULO"].map((x) => Modulo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "INVE_CODI": inveCodi,
        "INVE_DESC": inveDesc,
        "MODULO": List<dynamic>.from(modulo.map((x) => x.toJson())),
    };
}

class Modulo {
    int moduCodi;
    String moduDesc;

    Modulo({
        this.moduCodi,
        this.moduDesc,
    });

    factory Modulo.fromJson(Map<String, dynamic> json) => Modulo(
        moduCodi: json["MODU_CODI"],
        moduDesc: json["MODU_DESC"],
    );

    Map<String, dynamic> toJson() => {
        "MODU_CODI": moduCodi,
        "MODU_DESC": moduDesc,
    };
}

class User {
    int userCodi;
    String userDesc;

    User({
        this.userCodi,
        this.userDesc,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userCodi: json["USER_CODI"],
        userDesc: json["USER_DESC"],
    );

    Map<String, dynamic> toJson() => {
        "USER_CODI": userCodi,
        "USER_DESC": userDesc,
    };
}
