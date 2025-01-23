import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: AppColors.secondaryColor,
      ),
      child: Container(
        height: 155.0,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: _buildHeaderContent(),
      ),
    );
  }

  Widget _buildHeaderContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          Image.asset(
            'assets/images.png',
            height: 30.0,
            width: 150.0,
          ),
          const SizedBox(height: 6.0),

          // Name
          const Text(
            "MUHAMMAD AHMAD",
            style: TextStyle(color: AppColors.textColor),
          ),

          // Phone Number and Sign In Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "03028077453",
                style: TextStyle(
                  fontSize: 26,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16.0),
              // Sign In Button
              Container(
                height: 33.0,
                width: 120.0,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: TextButton(
                  onPressed: () {
                    // Define button press functionality here
                  },
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              )
            ],
          ),

          // Sign in prompt text
          const Text(
            'Sign in to your easypaisa account',
            style: TextStyle(fontSize: 13, color: AppColors.textColor),
          )
        ],
      ),
    );
  }
}
