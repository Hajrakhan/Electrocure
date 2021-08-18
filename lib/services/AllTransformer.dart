// To parse this JSON data, do
//
//     final Transformers = TransformersFromJson(jsonString);

import 'dart:convert';

List<Transformers> TransformersFromJson(String str) => List<Transformers>.from(json.decode(str).map((x) => Transformers.fromJson(x)));

String TransformersToJson(List<Transformers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transformers {
  Transformers({
    this.trid,
    this.name,
    this.kvaCapacity,
    this.datetime,
    this.description,
    this.c1,
    this.c2,
    this.c3,
    this.v1,
    this.v2,
    this.v3,
    this.pf1,
    this.pf2,
    this.pf3,
    this.status
  });

  String trid;
  String name;
  String kvaCapacity;
  DateTime datetime;
  String description;
  String c1;
  String c2;
  String c3;
  String v1;
  String v2;
  String v3;
  String pf1;
  String pf2;
  String pf3;
  String status;


  factory Transformers.fromJson(Map<String, dynamic> json) => Transformers(
    trid: json["trid"],
    name: json["name"],
    kvaCapacity: json["kva_capacity"],
    description: json["description"],
    datetime: DateTime.parse(json["datetime"]),
    c1: json["c1"],
    c2: json["c2"],
    c3: json["c3"],
    v1: json["v1"],
    v2: json["v2"],
    v3: json["v3"],
    pf1: json["pf1"],
    pf2: json["pf2"],
    pf3: json["pf3"],
    status: json["status"],

  );

  Map<String, dynamic> toJson() => {
    "trid": trid,
    "name": name,
    "kva_capacity": kvaCapacity,
    "description" : description,
    "datetime": datetime.toIso8601String(),
    "c1": c1,
    "c2": c2,
    "c3": c3,
    "v1": v1,
    "v2": v2,
    "v3": v3,
    "pf1": pf1,
    "pf2": pf2,
    "pf3": pf3,
    "status" :status
  };
}
