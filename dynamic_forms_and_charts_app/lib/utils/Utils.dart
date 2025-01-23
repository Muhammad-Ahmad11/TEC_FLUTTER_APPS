// ignore: file_names
import 'package:flutter/material.dart';

class Utils {
  // dynamic fields screen texts
  static const String dynamicFieldsScreenTitle = "Dynamic Fields Screen";
  static const String fieldsValueNotBeEmpty = "Field value cannot be empty";
  static const String fieldsValueValidNumber =
      "Field value must be a valid number";
  static const String invalidFieldValueText = "Invalid field value.";
  static const String fieldsSavedSuccess = "Fields saved successfully!";
  static const String addFieldText = "Please add a field first!";
  static const String fiveFieldsAllowedText = "Five Fields are allowed only";
  static const showChartText = "Display Chart";
  static const saveFieldsText = "Save Fields";

  // chart screen
  static const chartsScreenName = 'Charts';
  static const clearAllFieldsText = 'Clear all Fields';
  static const allFieldsClearedText = 'All fields cleared successfully!';
  static const noData = 'No data available to display charts.';
  static const invalidData = 'No valid data available to display charts.';
  static const barChartName = 'Bar Chart';
  static const pieChartname = 'Pie Chart';

  // SnackBars
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}
