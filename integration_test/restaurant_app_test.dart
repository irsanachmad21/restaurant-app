import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/main.dart';
import 'package:restaurant_app_api/provider/detail/bookmark_list_provider.dart';
import 'package:restaurant_app_api/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app_api/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app_api/provider/main/index_nav_provider.dart';
import 'package:restaurant_app_api/provider/notification/notification_provider.dart';
import 'package:restaurant_app_api/provider/theme/theme_provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Test', () {
    testWidgets('1. Menampilkan daftar restoran di halaman Home',
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
      expect(find.text("Home"), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('2. Mencari restoran dengan nama "Kafe"',
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
      final Finder searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);
      await tester.enterText(searchField, "Kafe");
      await tester.pumpAndSettle();
      expect(find.textContaining("Kafe"), findsWidgets);
    });
  });
}
