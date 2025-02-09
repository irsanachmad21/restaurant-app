import 'dart:convert';
import 'package:restaurant_app_api/data/model/restaurant_detail_model.dart';

RestaurantDetailResponse restaurantDetailModelFromJson(String str) =>
    RestaurantDetailResponse.fromJson(json.decode(str));

String restaurantDetailModelToJson(RestaurantDetailResponse data) =>
    json.encode(data.toJson());

class RestaurantDetailResponse {
  bool error;
  String message;
  RestaurantDetailModel restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetailModel.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}
