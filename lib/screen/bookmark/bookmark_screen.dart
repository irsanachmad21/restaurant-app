import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/data/model/restaurant_list_model.dart';
import 'package:restaurant_app_api/provider/detail/bookmark_list_provider.dart';
import 'package:restaurant_app_api/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app_api/static/navigation_route.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bookmarked Restaurants",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color(0xFF1877F2),
      ),
      body: Consumer<BookmarkListProvider>(
        builder: (context, value, child) {
          final bookmarkList = value.bookmarkList;
          return switch (bookmarkList.isNotEmpty) {
            true => ListView.builder(
                itemCount: bookmarkList.length,
                itemBuilder: (context, index) {
                  final restaurant = bookmarkList[index];

                  return RestaurantCard(
                    restaurant: RestaurantListModel(
                      id: restaurant.id,
                      name: restaurant.name,
                      description: restaurant.description,
                      pictureId: restaurant.pictureId,
                      city: restaurant.city,
                      rating: restaurant.rating,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationRoute.detailRoute.name,
                        arguments: restaurant.id,
                      );
                    },
                  );
                },
              ),
            _ => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No Bookmarked"),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
