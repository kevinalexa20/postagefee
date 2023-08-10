// To parse this JSON data, do
//
//     final costRequestModel = costRequestModelFromJson(jsonString);

import 'dart:convert';

class CostRequestModel {
  String origin;
  String destination;
  int weight;
  String courier;

  CostRequestModel({
    required this.origin,
    required this.destination,
    required this.weight,
    required this.courier,
  });

  factory CostRequestModel.fromRawJson(String str) =>
      CostRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CostRequestModel.fromJson(Map<String, dynamic> json) =>
      CostRequestModel(
        origin: json["origin"],
        destination: json["destination"],
        weight: json["weight"],
        courier: json["courier"],
      );

  Map<String, dynamic> toJson() => {
        "origin": origin,
        "destination": destination,
        "weight": weight,
        "courier": courier,
      };
}
