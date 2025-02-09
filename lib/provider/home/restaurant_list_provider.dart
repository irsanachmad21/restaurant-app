import 'package:flutter/material.dart';
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/static/restaurant_list_result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService _apiServices;

  RestaurantListProvider(
    this._apiServices,
  );

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantListErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> searchRestaurant(String query) async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = query.isEmpty
          ? await _apiServices.getRestaurantList()
          : await _apiServices.searchRestaurant(query);

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
      } else {
        if (result.restaurants.isEmpty) {
          _resultState = RestaurantListErrorState("No Restaurant Found");
        } else {
          _resultState = RestaurantListLoadedState(result.restaurants);
        }
      }
      notifyListeners();
    } on Exception catch (e) {
      _resultState = RestaurantListErrorState(e.toString());
      notifyListeners();
    }
  }
}
