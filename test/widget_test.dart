import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/main.dart';
import 'package:restaurant_app_api/provider/detail/bookmark_list_provider.dart';
import 'package:restaurant_app_api/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app_api/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app_api/provider/main/index_nav_provider.dart';
import 'package:restaurant_app_api/provider/notification/notification_provider.dart';
import 'package:restaurant_app_api/provider/theme/theme_provider.dart';
import 'package:restaurant_app_api/screen/bookmark/bookmark_screen.dart';
import 'package:restaurant_app_api/screen/home/home_screen.dart';
import 'package:restaurant_app_api/screen/main/main_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('Widget Testing', () {
    testWidgets('1. Mengecek komponen pada HomeScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
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

      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Restaurant Application'), findsOneWidget);

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);

      expect(find.byType(RefreshIndicator), findsOneWidget);

      expect(find.byType(BottomNavigationBar), findsOneWidget);

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Bookmarks'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('2. Navigasi dari HomeScreen ke BookmarkScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => IndexNavProvider()),
            ChangeNotifierProvider(create: (context) => BookmarkListProvider()),
            Provider(create: (context) => ApiService()),
            ChangeNotifierProvider(
                create: (context) =>
                    RestaurantListProvider(context.read<ApiService>())),
          ],
          child: const MaterialApp(
            home: MainScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(BookmarkScreen), findsNothing);

      await tester.tap(find.byIcon(Icons.bookmarks));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsNothing);
      expect(find.byType(BookmarkScreen), findsOneWidget);
    });
  });
}
