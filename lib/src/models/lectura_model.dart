// To parse this JSON data, do
//
//     final lecturaModel = lecturaModelFromJson(jsonString);

import 'dart:convert';

LecturaModel lecturaModelFromJson(String str) => LecturaModel.fromJson(json.decode(str));

String lecturaModelToJson(LecturaModel data) => json.encode(data.toJson());

class LecturaModel {
    LecturaModel({
        this.code,
        this.message,
        this.data,
    });

    String code;
    bool message;
    Data data;

    factory LecturaModel.fromJson(Map<String, dynamic> json) => LecturaModel(
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
    Data({
        this.agua,
        this.clima,
    });

    List<Agua> agua;
    List<Agua> clima;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        agua: List<Agua>.from(json["AGUA"].map((x) => Agua.fromJson(x))),
        clima: List<Agua>.from(json["CLIMA"].map((x) => Agua.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "AGUA": List<dynamic>.from(agua.map((x) => x.toJson())),
        "CLIMA": List<dynamic>.from(clima.map((x) => x.toJson())),
    };
}

class Agua {
    Agua({
        this.moduCodi,
        this.moduDesc,
        this.tipoCodi,
        this.tipoDesc,
        this.equiCodi,
        this.equiModel,
        this.equiUbic,
        this.detaValueLeid,
        this.mediDesc,
        this.mediDescAbre,
        this.detaDateLeid,
    });

    int moduCodi;
    String moduDesc;
    int tipoCodi;
    String tipoDesc;
    int equiCodi;
    String equiModel;
    String equiUbic;
    double detaValueLeid;
    String mediDesc;
    String mediDescAbre;
    DateTime detaDateLeid;

    factory Agua.fromJson(Map<String, dynamic> json) => Agua(
        moduCodi: json["MODU_CODI"],
        moduDesc: json["MODU_DESC"],
        tipoCodi: json["TIPO_CODI"],
        tipoDesc: json["TIPO_DESC"],
        equiCodi: json["EQUI_CODI"],
        equiModel: json["EQUI_MODEL"],
        equiUbic: json["EQUI_UBIC"],
        detaValueLeid: json["DETA_VALUE_LEID"].toDouble(),
        mediDesc: json["MEDI_DESC"],
        mediDescAbre: json["MEDI_DESC_ABRE"],
        detaDateLeid: DateTime.parse(json["DETA_DATE_LEID"]),
    );

    Map<String, dynamic> toJson() => {
        "MODU_CODI": moduCodi,
        "MODU_DESC": moduDesc,
        "TIPO_CODI": tipoCodi,
        "TIPO_DESC": tipoDesc,
        "EQUI_CODI": equiCodi,
        "EQUI_MODEL": equiModel,
        "EQUI_UBIC": equiUbic,
        "DETA_VALUE_LEID": detaValueLeid,
        "MEDI_DESC": mediDesc,
        "MEDI_DESC_ABRE": mediDescAbre,
        "DETA_DATE_LEID": detaDateLeid.toIso8601String(),
    };
}
