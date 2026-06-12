// To parse this JSON data, do
//
//     final getAllSubscriptionPlan = getAllSubscriptionPlanFromJson(jsonString);

import 'dart:convert';

GetAllSubscriptionPlan getAllSubscriptionPlanFromJson(String str) =>
    GetAllSubscriptionPlan.fromJson(json.decode(str));

String getAllSubscriptionPlanToJson(GetAllSubscriptionPlan data) =>
    json.encode(data.toJson());

class GetAllSubscriptionPlan {
  bool? success;
  String? message;
  List<AllPlan>? result;

  GetAllSubscriptionPlan({this.success, this.message, this.result});

  factory GetAllSubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      GetAllSubscriptionPlan(
        success: json["success"],
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<AllPlan>.from(
                json["result"]!.map((x) => AllPlan.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class AllPlan {
  String? id;
  String? pricingId;
  String? productId;
  String? interval; // kept as String, no enum
  int? intervalCount;
  double? price;
  String? title;
  List<Feature>? features;
  DateTime? createdAt;
  DateTime? updatedAt;

  AllPlan({
    this.id,
    this.pricingId,
    this.productId,
    this.interval,
    this.intervalCount,
    this.price,
    this.title,
    this.features,
    this.createdAt,
    this.updatedAt,
  });

  factory AllPlan.fromJson(Map<String, dynamic> json) => AllPlan(
    id: json["id"],
    pricingId: json["pricingId"],
    productId: json["productId"],
    interval: json["interval"], // String
    intervalCount: json["interval_count"],
    price: json["price"]?.toDouble(),
    title: json["title"],
    features: json["features"] == null
        ? []
        : List<Feature>.from(json["features"]!.map((x) => Feature.fromJson(x))),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pricingId": pricingId,
    "productId": productId,
    "interval": interval, // String
    "interval_count": intervalCount,
    "price": price,
    "title": title,
    "features": features == null
        ? []
        : List<dynamic>.from(features!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Feature {
  String? key; // String
  String? value; // String

  Feature({this.key, this.value});

  factory Feature.fromJson(Map<String, dynamic> json) =>
      Feature(key: json["key"], value: json["value"]);

  Map<String, dynamic> toJson() => {"key": key, "value": value};
}
