// To parse this JSON data, do
//
//     final Transformers = TransformersFromJson(jsonString);

import 'dart:convert';

List<db> dbFromJson(String str) => List<db>.from(json.decode(str).map((x) => db.fromJson(x)));

String dbToJson(List<db> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class db {
  db({
    this.dbid,
    this.name,
    this.datetime,
    this.c1,
    this.c2,
    this.c3,
    this.v1,
    this.v2,
    this.v3,
  });

  String dbid;
  String name;
  DateTime datetime;
  String c1;
  String c2;
  String c3;
  String v1;
  String v2;
  String v3;


  factory db.fromJson(Map<String, dynamic> json) => db(
    dbid: json["dbid"],
    name: json["name"],
    datetime: DateTime.parse(json["datetime"]),
    v1: json["v1"],
    v2: json["v2"],
    v3: json["v3"],
    c1: json["line1_c1"],
    c2: json["line1_c1"],
    c3: json["line1_c1"],

  );

  Map<String, dynamic> toJson() => {
    "dbid": dbid,
    "name": name,
    "datetime": datetime.toIso8601String(),
    "c1": c1,
    "c2": c2,
    "c3": c3,
    "v1": v1,
    "v2": v2,
    "v3": v3,
  };
}
