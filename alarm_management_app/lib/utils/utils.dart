import 'package:get/get.dart';
import 'package:task_07/models/alarm_model.dart';
import 'package:task_07/theme/colors.dart';
import 'package:task_07/utils/constants.dart';

class Utils {
  static void showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.secondaryColor,
      colorText: AppColors.backgroundColor,
    );
  }

  static void showSuccessSnackbar({AlarmModel? alarm}) {
    final message = alarm == null
        ? Constants.alarmAddedSuccess
        : Constants.alarmUpdatedSuccess;
    showSnackbar(Constants.successText, message);
  }
}
