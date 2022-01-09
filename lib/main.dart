import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dream_app_bloc/app.dart';
import 'package:dream_app_bloc/networking/api_client.dart';
import 'package:dream_app_bloc/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load();
  AwesomeNotifications().initialize(
    "resource://drawable/ic_dj",
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: 'This will be use for daily reminder notification',
      ),
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.indigoAccent,
        locked: true,
        importance: NotificationImportance.High,
        channelDescription: 'This will be use for daily reminder notification',
      ),
    ],
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(
      apiClient: ApiClient(),
      router: AppRouter(),
    ),
  );
}
