import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

Future<void> createDailyReminderNotification(
    TimeOfDay timeOfDay) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'scheduled_channel',
      title: '${Emojis.sky_star} Do you have a dream?',
      body: 'Record your dream now and keep it so you will never forget your dream again',
      notificationLayout: NotificationLayout.BigText,
    ),
    schedule: NotificationCalendar(
      hour: timeOfDay.hour,
      minute: timeOfDay.minute,
      second: 0,
      millisecond: 0,
      repeats: true
    ),
  );
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}