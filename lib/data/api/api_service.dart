import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_app_api/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app_api/data/model/restaurant_list_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/list"));
      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 1));
        return RestaurantListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load restaurant list');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      throw Exception('Failed to load restaurant list: $e');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(
      String restaurantId) async {
    try {
      final response =
          await http.get(Uri.parse("$_baseUrl/detail/$restaurantId"));
      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 1));
        return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load restaurant list');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      throw Exception('Failed to load restaurant list: $e');
    }
  }

  Future<RestaurantListResponse> searchRestaurant(String query) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 1));
        return RestaurantListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to search restaurant');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      throw Exception('Failed to search restaurant: $e');
    }
  }

  Future<void> submitReview(
      String id, String name, String review, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/review"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': id,
          'name': name,
          'review': review,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['error'] == false &&
            responseBody['message'] == 'success') {
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Gagal menambahkan review: ${responseBody['message']}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan. Silakan coba lagi.')),
      );
    }
  }
}
