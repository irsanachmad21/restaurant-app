import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/provider/detail/bookmark_list_provider.dart';
import 'package:restaurant_app_api/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app_api/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app_api/provider/main/index_nav_provider.dart';
import 'package:restaurant_app_api/provider/notification/notification_provider.dart';
import 'package:restaurant_app_api/provider/theme/theme_provider.dart';
import 'package:restaurant_app_api/screen/detail/detail_screen.dart';
import 'package:restaurant_app_api/screen/main/main_screen.dart';
import 'package:restaurant_app_api/screen/settings/setting_screen.dart';
import 'package:restaurant_app_api/service/notification_service.dart';
import 'package:restaurant_app_api/static/navigation_route.dart';
import 'package:restaurant_app_api/style/theme/restaurant_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  // Initialize notification service
  final notificationService = NotificationService();
  await notificationService.initNotification();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        ChangeNotifierProvider(create: (context) => BookmarkListProvider()),
        Provider(create: (context) => ApiService()),
        ChangeNotifierProvider(
            create: (context) =>
                RestaurantListProvider(context.read<ApiService>())),
        ChangeNotifierProvider(
            create: (context) =>
                RestaurantDetailProvider(context.read<ApiService>())),
        ChangeNotifierProvider(
            create: (context) => ThemeProvider()..loadTheme()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Restaurant App',
          debugShowCheckedModeBanner: false,
          theme: RestaurantTheme.lightTheme,
          darkTheme: RestaurantTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          initialRoute: NavigationRoute.mainRoute.name,
          routes: {
            NavigationRoute.mainRoute.name: (context) => const MainScreen(),
            NavigationRoute.detailRoute.name: (context) {
              final restaurantId =
                  ModalRoute.of(context)?.settings.arguments as String;
              return DetailScreen(restaurantId: restaurantId);
            },
            NavigationRoute.settingsRoute.name: (context) =>
                const SettingsScreen(),
          },
        );
      },
    );
  }
}
