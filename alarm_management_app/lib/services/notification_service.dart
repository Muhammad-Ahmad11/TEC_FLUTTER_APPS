import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:task_07/models/alarm_model.dart';
import 'package:task_07/utils/constants.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../viewmodels/alarm_view_model.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Common Notification Details
  static const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
    'alarm_channel',
    'Alarm Notifications',
    importance: Importance.high,
    priority: Priority.high,
  );

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);
    _notificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    tz.initializeTimeZones(); // Initialize time zones
  }

  // Handles actions when a notification is tapped or interacted with
  static void onDidReceiveNotificationResponse(
      NotificationResponse response) async {
    debugPrint('NotificationResponse received: ${response.payload}');

    if (response.payload != "cancel") {
      final alarmViewModel = Get.find<AlarmViewModel>();
      final alarmId = response.payload;
      alarmViewModel.snoozeAlarm(alarmId!);
    }
  }

  // Show regular notification
  static Future<void> showNotification(
      String id, String title, String body) async {
    await _notificationsPlugin.show(
      id.hashCode,
      title,
      body,
      const NotificationDetails(android: androidDetails),
      payload: "cancel",
    );
  }

  // Show notification with a snooze button
  static Future<void> showSnoozeButtonNotification(AlarmModel alarm) async {
    String id = alarm.id;
    DateTime time = alarm.time;
    final tz.TZDateTime tzDateTime = tz.TZDateTime.from(time, tz.local);
    debugPrint("Scheduling alarm for $id at $tzDateTime");

    const AndroidNotificationDetails androidSnoozeDetails =
        AndroidNotificationDetails(
      Constants.alarmChannel,
      Constants.alarmNotifications,
      importance: Importance.high,
      priority: Priority.high,
      actions: [
        AndroidNotificationAction(
          Constants.snoozeActionId, // action ID
          Constants.snoozeButtonText, // button text
        )
      ],
    );

    await _notificationsPlugin.zonedSchedule(
      id.hashCode,
      Constants.timeUpMessage,
      Constants.tapSnoozeMessage,
      tzDateTime,
      const NotificationDetails(android: androidSnoozeDetails),
      payload: id,
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // Cancel notification by ID
  static Future<void> cancelNotification(String id) async {
    await _notificationsPlugin.cancel(id.hashCode);
    debugPrint(Constants.cancelNotificationMessage);
  }

  // Schedule alarm at a specific time
  static Future<void> scheduleNotification(String id, DateTime time) async {
    final tz.TZDateTime tzDateTime = tz.TZDateTime.from(time, tz.local);
    debugPrint("Scheduling alarm for $id at $tzDateTime");

    await _notificationsPlugin.zonedSchedule(
      id.hashCode,
      Constants.timeUpMessage,
      Constants.timeForAlarmMessage,
      tzDateTime,
      const NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> scheduleRecurringAlarm(String id, DateTime time) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime scheduledTime = tz.TZDateTime.from(time, tz.local);

    // Ensure the scheduled time is in the future
    tz.TZDateTime firstAlarmTime = scheduledTime.isBefore(now)
        ? scheduledTime.add(const Duration(days: 1))
        : scheduledTime;

    await _notificationsPlugin.zonedSchedule(
      id.hashCode,
      Constants.recurringAlarmMessage,
      Constants.recurringAlarmDescription,
      firstAlarmTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'recurring_alarm_channel',
          'Recurring Alarm Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      matchDateTimeComponents:
          DateTimeComponents.time, // Ensures daily recurrence
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
