import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/language_controller.dart';
import '../controllers/theme_controller.dart';

class MenuPage extends StatelessWidget {
  final languageController = Get.find<LanguageController>();
  final themeController = Get.find<ThemeController>();

  MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Switching Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Dark Mode',
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Obx(() {
                  return Switch(
                    value: themeController.isDarkMode.value,
                    onChanged: (value) {
                      themeController.toggleTheme();
                    },
                    activeColor: Colors.green,
                  );
                }),
              ],
            ),
            const SizedBox(height: 20),

            // Language Switching Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Language',
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Obx(() {
                  return Switch(
                    value:
                        languageController.currentLocale.value.languageCode ==
                            'ur',
                    onChanged: (value) {
                      languageController.switchLanguage(value);
                    },
                    activeColor: Colors.green,
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
