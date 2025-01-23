# Alarm Management App (Flutter)

This Flutter app allows users to set and manage alarms, including one-time and recurring alarms. It uses GetX for state management and `flutter_local_notifications` for scheduling and displaying notifications.

## Features:

### 1. **State Management**
- **GetX** is used for managing alarm states (setting, snoozing, and displaying alarms).

### 2. **Alarm Screen**
- **Set Alarms:** Users can set both one-time and recurring alarms.
- **Snooze Alarms:** Option to snooze alarms for a set duration.
- **Alarm List:** Displays a list of active alarms with options to edit or delete them.

### 3. **Notifications**
- **Schedule Notifications:** Alarms trigger notifications using `flutter_local_notifications` to alert users at the scheduled time.

## Topics Covered:
- **Notifications:** Scheduling and displaying local notifications for alarms.
- **GetX:** Efficient state management for alarm data.
- **Time Scheduling:** Managing one-time and recurring alarms.