import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ride_lanka/core/constants/app_assets.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';
import 'package:ride_lanka/features/auth/widgets/budget_tab_switch.dart';
import 'package:ride_lanka/widgets/primary_button.dart';

class MetaDataScreen extends StatefulWidget {
  const MetaDataScreen({super.key});

  @override
  State<MetaDataScreen> createState() => _MetaDataScreenState();
}

class _MetaDataScreenState extends State<MetaDataScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> interests = [
      'Hiking',
      'Adventure',
      'Wildlife',
      'Culture',
      'Food & Dining',
      'Nightlife',
      'Relaxation',
    ];
    List<String> travelStyles = [
      'Solo Travel',
      'Couple Travel',
      'Family Travel',
      'Friends Travel',
    ];
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.logo,
                    color: AppColors.black,
                    height: 30,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Ride\nLanka',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Text(
                'Tell us what you love',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Text(
                'We’ll use this to personalize your Sri Lankan\ntravel experience from peaks to placing.',
                style: TextStyle(fontSize: 18, color: AppColors.subtitleText),
              ),
              SizedBox(height: 30),
              Text(
                'Your interests',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  interests.length,
                  (index) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.chipBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(interests[index]),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Travel Style',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  travelStyles.length,
                  (index) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.chipBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(travelStyles[index]),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Budget Preference',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              BudgetTabSwitch(
                values: const ['Low', 'Medium', 'Premium'],
                onToggleCallback: (index) {
                  String selectedValue = ['Low', 'Medium', 'Premium'][index];
                  Logger().i('Selected Budget Preference: $selectedValue');
                  // Update your Firestore data array here
                },
              ),
              Spacer(),
              PrimaryButton(buttonText: 'Continue', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
