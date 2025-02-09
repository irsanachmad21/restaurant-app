import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/provider/main/index_nav_provider.dart';
import 'package:restaurant_app_api/screen/bookmark/bookmark_screen.dart';
import 'package:restaurant_app_api/screen/home/home_screen.dart';
import 'package:restaurant_app_api/static/navigation_route.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            1 => const BookmarkScreen(),
            _ => const HomeScreen(),
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onTap: (index) {
          if (index == 2) {
            // Jika index 2 (Settings) dipilih, navigasi ke halaman settings
            Navigator.pushNamed(context, NavigationRoute.settingsRoute.name);
          } else {
            // Jika tidak, update IndexNavProvider untuk halaman lainnya
            context.read<IndexNavProvider>().setIndextBottomNavBar = index;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks),
            label: "Bookmarks",
            tooltip: "Bookmarks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), // Ikon untuk Settings
            label: "Settings", // Label untuk Settings
            tooltip: "Settings", // Tooltip untuk Settings
          ),
        ],
      ),
    );
  }
}
