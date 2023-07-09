// To parse this JSON data, do
//
//     final costModel = costModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CostModel {
    final Rajaongkir rajaongkir;

    CostModel({
        required this.rajaongkir,
    });

    factory CostModel.fromRawJson(String str) => CostModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CostModel.fromJson(Map<String, dynamic> json) => CostModel(
        rajaongkir: Rajaongkir.fromJson(json["rajaongkir"]),
    );

    Map<String, dynamic> toJson() => {
        "rajaongkir": rajaongkir.toJson(),
    };
}

class Rajaongkir {
    final Query query;
    final Status status;
    final NDetails originDetails;
    final NDetails destinationDetails;
    final List<Result> results;

    Rajaongkir({
        required this.query,
        required this.status,
        required this.originDetails,
        required this.destinationDetails,
        required this.results,
    });

    factory Rajaongkir.fromRawJson(String str) => Rajaongkir.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Rajaongkir.fromJson(Map<String, dynamic> json) => Rajaongkir(
        query: Query.fromJson(json["query"]),
        status: Status.fromJson(json["status"]),
        originDetails: NDetails.fromJson(json["origin_details"]),
        destinationDetails: NDetails.fromJson(json["destination_details"]),
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "query": query.toJson(),
        "status": status.toJson(),
        "origin_details": originDetails.toJson(),
        "destination_details": destinationDetails.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class NDetails {
    final String cityId;
    final String provinceId;
    final String province;
    final String type;
    final String cityName;
    final String postalCode;

    NDetails({
        required this.cityId,
        required this.provinceId,
        required this.province,
        required this.type,
        required this.cityName,
        required this.postalCode,
    });

    factory NDetails.fromRawJson(String str) => NDetails.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NDetails.fromJson(Map<String, dynamic> json) => NDetails(
        cityId: json["city_id"],
        provinceId: json["province_id"],
        province: json["province"],
        type: json["type"],
        cityName: json["city_name"],
        postalCode: json["postal_code"],
    );

    Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "province_id": provinceId,
        "province": province,
        "type": type,
        "city_name": cityName,
        "postal_code": postalCode,
    };
}

class Query {
    final String origin;
    final String destination;
    final int weight;
    final String courier;

    Query({
        required this.origin,
        required this.destination,
        required this.weight,
        required this.courier,
    });

    factory Query.fromRawJson(String str) => Query.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Query.fromJson(Map<String, dynamic> json) => Query(
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

class Result {
    final String code;
    final String name;
    final List<ResultCost> costs;

    Result({
        required this.code,
        required this.name,
        required this.costs,
    });

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["code"],
        name: json["name"],
        costs: List<ResultCost>.from(json["costs"].map((x) => ResultCost.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "costs": List<dynamic>.from(costs.map((x) => x.toJson())),
    };
}

class ResultCost {
    final String service;
    final String description;
    final List<CostCost> cost;

    ResultCost({
        required this.service,
        required this.description,
        required this.cost,
    });

    factory ResultCost.fromRawJson(String str) => ResultCost.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResultCost.fromJson(Map<String, dynamic> json) => ResultCost(
        service: json["service"],
        description: json["description"],
        cost: List<CostCost>.from(json["cost"].map((x) => CostCost.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": List<dynamic>.from(cost.map((x) => x.toJson())),
    };
}

class CostCost {
    final int value;
    final String etd;
    final String note;

    CostCost({
        required this.value,
        required this.etd,
        required this.note,
    });

    factory CostCost.fromRawJson(String str) => CostCost.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CostCost.fromJson(Map<String, dynamic> json) => CostCost(
        value: json["value"],
        etd: json["etd"],
        note: json["note"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "etd": etd,
        "note": note,
    };
}

class Status {
    final int code;
    final String description;

    Status({
        required this.code,
        required this.description,
    });

    factory Status.fromRawJson(String str) => Status.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
    };
}
