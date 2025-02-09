import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_app_api/service/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  bool _isReminderOn = false;
  final NotificationService _notificationService = NotificationService();

  bool get isReminderOn => _isReminderOn;

  NotificationProvider() {
    _loadReminderStatus();
  }

  Future<void> _loadReminderStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isReminderOn = prefs.getBool('daily_reminder') ?? false;
    notifyListeners();

    if (_isReminderOn) {
      _scheduleNotification();
    }
  }

  Future<void> setReminderStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isReminderOn = value;
    await prefs.setBool('daily_reminder', value);
    notifyListeners();

    if (value) {
      _scheduleNotification();
    } else {
      _notificationService.cancelNotification(1);
    }
  }

  Future<String> _fetchRandomRestaurantName() async {
    const String apiUrl = 'https://restaurant-api.dicoding.dev/list';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List restaurants = data['restaurants'];
        final randomIndex = Random().nextInt(restaurants.length);
        return restaurants[randomIndex]['name'];
      } else {
        throw Exception('Failed to fetch restaurants');
      }
    } catch (e) {
      return 'Unknown Restaurant';
    }
  }

  Future<void> _scheduleNotification() async {
    String restaurantName = await _fetchRandomRestaurantName();

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 11, 0);

    if (now.isAfter(scheduledDate)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }

    _notificationService.scheduleNotification(
      title: '$restaurantName',
      body: 'It\'s time to eat lunch!',
      hour: scheduledDate.hour,
      minute: scheduledDate.minute,
    );
  }
}
