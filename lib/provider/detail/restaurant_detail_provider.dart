import 'package:flutter/material.dart';
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/static/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService _apiServices;

  RestaurantDetailProvider(this._apiServices);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();

  RestaurantDetailResultState get resultState => _resultState;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      
      Future.microtask(() {
        notifyListeners();
      });

      final result = await _apiServices.getRestaurantDetail(id);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        Future.microtask(() {
          notifyListeners();
        });
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        Future.microtask(() {
          notifyListeners();
        });
      }
    } on Exception catch (e) {
      _resultState = RestaurantDetailErrorState(e.toString());
      Future.microtask(() {
        notifyListeners();
      });
    }
  }
}
