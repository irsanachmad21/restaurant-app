import 'package:restaurant_app_api/data/model/restaurant_detail_model.dart';

sealed class RestaurantDetailResultState {}

class RestaurantDetailNoneState extends RestaurantDetailResultState {}
 
class RestaurantDetailLoadingState extends RestaurantDetailResultState {}
 
class RestaurantDetailErrorState extends RestaurantDetailResultState {
 final String error;
 
 RestaurantDetailErrorState(this.error);
}
 
class RestaurantDetailLoadedState extends RestaurantDetailResultState {
 final RestaurantDetailModel data;
 
 RestaurantDetailLoadedState(this.data);
}