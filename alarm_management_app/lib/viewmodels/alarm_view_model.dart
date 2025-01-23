import 'package:get/get.dart';
import 'package:task_07/models/alarm_model.dart';
import 'package:task_07/services/notification_service.dart';
import 'package:task_07/utils/constants.dart';

class AlarmViewModel extends GetxController {
  var alarms = <AlarmModel>[].obs;

  void addAlarm(AlarmModel alarm) {
    alarms.add(alarm);

    setNotificationType(alarm);
  }

  void toggleAlarm(String id) {
    int index = alarms.indexWhere((alarm) => alarm.id == id);
    if (index != -1) {
      AlarmModel alarm = alarms[index];

      if (!alarm.isActive) {
        // Activating the alarm
        DateTime now = DateTime.now();
        DateTime alarmTime = alarm.time;

        // Ensure the alarm time is in the future
        if (alarmTime.isBefore(now)) {
          alarmTime = alarmTime.add(const Duration(days: 1));
        }

        setNotificationType(alarm);

        // Update the alarm time and active status
        alarms[index] = alarm.copyWith(isActive: true, time: alarmTime);
      } else {
        // Deactivating the alarm
        NotificationService.cancelNotification(alarm.id);

        // Update the active status
        alarms[index] = alarm.copyWith(isActive: false);
      }

      // Refresh the alarms list to reflect changes in the view
      alarms.refresh();
    }
  }

  // update the alarm
  void updateAlarm(AlarmModel newAlarm, String id) {
    int index = alarms.indexWhere((alarm) => alarm.id == id);
    if (index != -1) {
      alarms[index] = newAlarm;
      setNotificationType(alarms[index]);
    }
  }

  // delete the alarm
  void deleteAlarm(String id) {
    int index = alarms.indexWhere((alarm) => alarm.id == id);
    if (index != -1) {
      NotificationService.cancelNotification(alarms[index].id);
      alarms.removeAt(index);
    }
  }

  // snooze the alarm
  void snoozeAlarm(String id) {
    int index = alarms.indexWhere((alarm) => alarm.id == id);
    if (index != -1) {
      alarms[index] = alarms[index]
          .copyWith(time: alarms[index].time.add(const Duration(minutes: 1)));

      NotificationService.showSnoozeButtonNotification(alarms[index]);

      //NotificationService.cancelNotification(id);

      NotificationService.showNotification(
          id, Constants.alarmSnoozedText, Constants.alarmSnoozedTextDetailed);
      alarms.refresh();
    }
  }

  // set notification type recurring/snooze
  void setNotificationType(AlarmModel alarm) {
    if (alarm.isRecurring) {
      NotificationService.scheduleRecurringAlarm(alarm.id, alarm.time);
    } else {
      NotificationService.showSnoozeButtonNotification(alarm);
    }
  }
}
