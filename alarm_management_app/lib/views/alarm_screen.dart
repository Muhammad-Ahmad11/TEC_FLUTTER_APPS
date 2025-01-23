import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_07/models/alarm_model.dart';
import 'package:task_07/theme/colors.dart';
import 'package:task_07/utils/constants.dart';
import 'package:task_07/utils/dimensions.dart';
import 'package:task_07/viewmodels/alarm_view_model.dart';
import 'package:task_07/views/edit_alarm_screen.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    final AlarmViewModel alarmViewModel = Get.put(AlarmViewModel());

    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.alarmActivityName),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimension.padding),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (alarmViewModel.alarms.isEmpty) {
                  return const Center(
                    child: Text(
                      Constants.noAlarmsSetText,
                      style: TextStyle(
                          color: AppColors.greyColor,
                          fontSize: Dimension.fontSizeSubtitle),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: alarmViewModel.alarms.length,
                  padding: const EdgeInsets.all(Dimension.cardPadding),
                  itemBuilder: (context, index) {
                    final AlarmModel alarm = alarmViewModel.alarms[index];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            Dimension.borderRadiusPadding),
                      ),
                      elevation: Dimension.cardElevation,
                      child: ListTile(
                        leading: Icon(
                          alarm.isRecurring ? Icons.repeat : Icons.alarm,
                          color: AppColors.secondaryColor,
                          size: Dimension.iconSize,
                        ),
                        title: Text(
                          _formatTime12Hour(dateTimeToTimeOfDay(alarm.time)),
                          style: const TextStyle(
                              fontSize: Dimension.fontSizeTitle,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(alarm.isRecurring
                            ? Constants.recurringAlarmText
                            : Constants.oneTimeAlarmText),
                        trailing: Switch(
                          value: alarm.isActive,
                          onChanged: (value) =>
                              alarmViewModel.toggleAlarm(alarm.id),
                          activeColor: AppColors.primaryColor,
                          inactiveThumbColor: AppColors.greyColor,
                          inactiveTrackColor: Colors.grey.shade300,
                        ),
                        onTap: () {
                          Get.to(() => EditAlarmScreen(alarm: alarm));
                        },
                        onLongPress: () {
                          alarmViewModel.deleteAlarm(alarm.id);
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => EditAlarmScreen()),
        backgroundColor: AppColors.secondaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Convert DateTime to TimeOfDay object to extract hour and minute
  TimeOfDay dateTimeToTimeOfDay(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  // Format time to 12-hour format (e.g., 12:00 PM)
  String _formatTime12Hour(TimeOfDay time) {
    final DateTime dateTime = DateTime(0, 0, 0, time.hour, time.minute);
    final DateFormat timeFormat = DateFormat(Constants.dateFormat);
    return timeFormat.format(dateTime);
  }
}
