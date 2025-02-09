import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/provider/notification/notification_provider.dart';
import 'package:restaurant_app_api/provider/theme/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20)),
        backgroundColor: const Color(0xFF1877F2),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Dark Theme'),
              trailing: Switch(
                value: Provider.of<ThemeProvider>(context).themeMode ==
                    ThemeMode.dark,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
              ),
            ),
            Consumer<NotificationProvider>(
              builder: (context, notificationProvider, child) {
                return ListTile(
                  title: const Text('Restaurant Notification'),
                  trailing: Switch(
                    value: notificationProvider.isReminderOn,
                    onChanged: (value) {
                      notificationProvider.setReminderStatus(value);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
