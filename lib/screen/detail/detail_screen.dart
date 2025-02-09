import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/provider/detail/bookmark_icon_provider.dart';
import 'package:restaurant_app_api/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app_api/screen/detail/body_of_detail_screen_widget.dart';
import 'package:restaurant_app_api/screen/detail/bookmark_icon_widget.dart';
import 'package:restaurant_app_api/static/restaurant_detail_result_state.dart';

class DetailScreen extends StatelessWidget {
  final String restaurantId;

  const DetailScreen({
    super.key,
    required this.restaurantId,
  });

  Future<void> _refreshPage(BuildContext context) async {
    await context
        .read<RestaurantDetailProvider>()
        .fetchRestaurantDetail(restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Restaurant Detail",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color(0xFF1877F2),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          ChangeNotifierProvider(
            create: (context) => BookmarkIconProvider(),
            child: Consumer<RestaurantDetailProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantDetailLoadedState(data: var restaurant) =>
                    BookmarkIconWidget(restaurant: restaurant),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: context
            .read<RestaurantDetailProvider>()
            .fetchRestaurantDetail(restaurantId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refreshPage(context),
            child: Consumer<RestaurantDetailProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantDetailLoadingState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  RestaurantDetailLoadedState(data: var restaurant) =>
                    BodyOfDetailScreenWidget(restaurant: restaurant),
                  RestaurantDetailErrorState(error: var message) => Center(
                      child: Text(message),
                    ),
                  _ => const SizedBox(),
                };
              },
            ),
          );
        },
      ),
    );
  }
}
