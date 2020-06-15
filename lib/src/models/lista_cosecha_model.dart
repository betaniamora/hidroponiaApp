// To parse this JSON data, do
//
//     final listaCosechasModel = listaCosechasModelFromJson(jsonString);

import 'dart:convert';

ListaCosechasModel listaCosechasModelFromJson(String str) => ListaCosechasModel.fromJson(json.decode(str));

String listaCosechasModelToJson(ListaCosechasModel data) => json.encode(data.toJson());

class ListaCosechasModel {
    ListaCosechasModel({
        this.code,
        this.message,
        this.data,
    });

    String code;
    bool message;
    List<Datum> data;

    factory ListaCosechasModel.fromJson(Map<String, dynamic> json) => ListaCosechasModel(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.desc,
        this.cant,
        this.fase1,
        this.fase2,
        this.fase3,
        this.fase4,
        this.inveCodi,
    });

    String desc;
    int cant;
    String fase1;
    String fase2;
    DateTime fase3;
    DateTime fase4;
    int inveCodi;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        desc: json["DESC"],
        cant: json["CANT"],
        fase1: json["FASE_1"],
        fase2: json["FASE_2"],
        fase3: DateTime.parse(json["FASE_3"]),
        fase4: DateTime.parse(json["FASE_4"]),
        inveCodi: json["INVE_CODI"],
    );

    Map<String, dynamic> toJson() => {
        "DESC": desc,
        "CANT": cant,
        "FASE_1": fase1,
        "FASE_2": fase2,
        "FASE_3": fase3.toIso8601String(),
        "FASE_4": fase4.toIso8601String(),
        "INVE_CODI": inveCodi,
    };
}


