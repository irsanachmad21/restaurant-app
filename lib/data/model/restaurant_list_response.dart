import 'package:restaurant_app_api/data/model/restaurant_list_model.dart';

class RestaurantListResponse {
  final bool error;
  final String message;
  final int count;
  final List<RestaurantListModel> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantListResponse(
      error: json["error"],
      message: json["message"] ?? "",
      count: json["count"] ?? 0,
      restaurants: json["restaurants"] != null
          ? List<RestaurantListModel>.from(
              json["restaurants"].map((x) => RestaurantListModel.fromJson(x)))
          : <RestaurantListModel>[],
    );
  }
}
