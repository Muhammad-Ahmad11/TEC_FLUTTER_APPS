import 'package:flutter/material.dart';
import 'package:task_08/theme/colors.dart';

import '../widgets/custom_appBar_widget.dart';
import '../widgets/custom_header_widget.dart';
import '../widgets/placeholder_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.homeBackground,
        appBar: CustomAppBar(),
        body: Column(
          children: [
            CustomHeaderWidget(),
            _buildBillingAndPaymentWidget(),
          ],
        ));
  }

  Widget _buildBillingAndPaymentWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: PlaceholderWidget(
                  title: 'Send Money',
                  icon: Icons.mobile_friendly,
                ),
              ),
              const SizedBox(width: 16.0), // Add some space between cards
              Expanded(
                child: PlaceholderWidget(
                  title: 'Bill Payment',
                  icon: Icons.star,
                ),
              ),
              const SizedBox(width: 16.0), // Add some space between cards
              Expanded(
                child: PlaceholderWidget(
                  title: 'Mobile Packages',
                  icon: Icons.settings,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
