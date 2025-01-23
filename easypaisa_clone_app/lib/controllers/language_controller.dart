import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  // Observable variable to track the current locale
  Rx<Locale> currentLocale = const Locale('en', 'US').obs;

  // Method to switch between English and Urdu
  void switchLanguage(bool isUrdu) {
    if (isUrdu) {
      currentLocale.value = const Locale('ur', 'PK');
      Get.updateLocale(const Locale('ur', 'PK'));
    } else {
      currentLocale.value = const Locale('en', 'US');
      Get.updateLocale(const Locale('en', 'US'));
    }
  }
}
