import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: IconButton(
          icon: Icon(Icons.person, color: Colors.white),
          onPressed: null,
        ),
      ),
      title: const Text(
        "easypaisa",
        style: TextStyle(
            color: AppColors.backgroundColor, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: const [
        IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(Icons.notifications_none_rounded, color: Colors.white),
          onPressed: null,
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(56.0); // Set height for AppBar
}
