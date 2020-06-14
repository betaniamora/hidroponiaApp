// To parse this JSON data, do
//
//     final confPlantModel = confPlantModelFromJson(jsonString);

import 'dart:convert';

ConfPlantModel confPlantModelFromJson(String str) => ConfPlantModel.fromJson(json.decode(str));

String confPlantModelToJson(ConfPlantModel data) => json.encode(data.toJson());

class ConfPlantModel {
    ConfPlantModel({
        this.code,
        this.message,
        this.data,
    });

    String code;
    bool message;
    List<Datum> data;

    factory ConfPlantModel.fromJson(Map<String, dynamic> json) => ConfPlantModel(
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
        this.confCodi,
        this.plantDesc,
        this.inveCodi,
    });

    int confCodi;
    String plantDesc;
    int inveCodi;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        confCodi: json["CONF_CODI"],
        plantDesc: json["PLANT_DESC"],
        inveCodi: json["INVE_CODI"],
    );

    Map<String, dynamic> toJson() => {
        "CONF_CODI": confCodi,
        "PLANT_DESC": plantDesc,
        "INVE_CODI": inveCodi,
    };
}
