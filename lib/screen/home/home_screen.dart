import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app_api/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app_api/static/navigation_route.dart';
import 'package:restaurant_app_api/static/restaurant_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  Future<void> _refreshPage() async {
    await context.read<RestaurantListProvider>().fetchRestaurantList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurant Application',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color(0xFF1877F2),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPage,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (query) {
                  if (query.isEmpty) {
                    context.read<RestaurantListProvider>().searchRestaurant("");
                  } else {
                    context
                        .read<RestaurantListProvider>()
                        .searchRestaurant(query);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search restaurant...',
                  hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<RestaurantListProvider>(
                builder: (context, value, child) {
                  return switch (value.resultState) {
                    RestaurantListLoadingState() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    RestaurantListLoadedState(data: var restaurantList) =>
                      ListView.builder(
                        itemCount: restaurantList.length,
                        itemBuilder: (context, index) {
                          final restaurant = restaurantList[index];
                          return RestaurantCard(
                            restaurant: restaurant,
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
                    RestaurantListErrorState(error: var message) => Center(
                        child: Text(message),
                      ),
                    _ => const SizedBox(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
