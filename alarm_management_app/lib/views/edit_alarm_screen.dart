import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_07/models/alarm_model.dart';
import 'package:task_07/theme/colors.dart';
import 'package:task_07/utils/dimensions.dart';
import 'package:task_07/utils/constants.dart';
import 'package:task_07/utils/utils.dart';
import 'package:task_07/viewmodels/alarm_view_model.dart';

class EditAlarmScreen extends StatelessWidget {
  final AlarmModel? alarm;

  EditAlarmScreen({super.key, this.alarm});

  final AlarmViewModel alarmViewModel = Get.find<AlarmViewModel>();

  @override
  Widget build(BuildContext context) {
    final Rx<TimeOfDay> selectedTime =
        (alarm != null ? TimeOfDay.fromDateTime(alarm!.time) : TimeOfDay.now())
            .obs;

    final RxBool isRecurring = (alarm?.isRecurring ?? false).obs;

    return Scaffold(
      appBar: AppBar(
        title: Text(alarm == null ? Constants.addAlarm : Constants.editAlarm),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimension.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              Constants.selectTimeText,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: Dimension.fontSizeTitle,
                fontWeight: FontWeight.normal,
              ),
            ),
            GestureDetector(
              onTap: () => _selectTime(context, selectedTime),
              child: Obx(() {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.secondaryColor),
                    borderRadius:
                        BorderRadius.circular(Dimension.borderRadiusPadding),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimension.edgeInsectsPAdding),
                    child: Text(
                      selectedTime.value.format(context),
                      style:
                          const TextStyle(fontSize: Dimension.fontSizeSubtitle),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: Dimension.sizedBoxHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  Constants.recurringText,
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: Dimension.fontSizeTitle,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Obx(() => Switch(
                      value: isRecurring.value,
                      onChanged: (value) {
                        isRecurring.value = value;
                      },
                      activeColor: AppColors.primaryColor,
                      inactiveThumbColor: AppColors.greyColor,
                      inactiveTrackColor: Colors.grey.shade300,
                    )),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _saveAlarm(selectedTime, isRecurring),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                minimumSize:
                    const Size(double.infinity, Dimension.buttonHeight),
              ),
              child: Text(
                alarm == null ? Constants.addAlarm : Constants.editAlarm,
                style: const TextStyle(
                    fontSize: Dimension.fontSizeButton,
                    color: AppColors.backgroundColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // show timer picker
  void _selectTime(BuildContext context, Rx<TimeOfDay> selectedTime) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: selectedTime.value);

    if (picked != null) {
      selectedTime.value = picked;
    }
  }

  // save or update alarm
  void _saveAlarm(Rx<TimeOfDay> selectedTime, RxBool isRecurring) {
    final DateTime now = DateTime.now();
    final DateTime alarmTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.value.hour,
      selectedTime.value.minute,
    );

    final newAlarm = AlarmModel(
      id: alarm?.id ?? DateTime.now().toString(),
      time: alarmTime,
      isRecurring: isRecurring.value,
      isActive: true,
    );

    if (alarm == null) {
      alarmViewModel.addAlarm(newAlarm);
    } else {
      alarmViewModel.updateAlarm(newAlarm, newAlarm.id);
    }

    // go to the previous screen
    Get.back();

    // show success snackbar
    Utils.showSuccessSnackbar(alarm: alarm);
  }
}
