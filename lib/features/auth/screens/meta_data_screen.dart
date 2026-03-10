import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_lanka/core/constants/app_assets.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';
import 'package:ride_lanka/features/auth/providers/meta_data_provider.dart';
import 'package:ride_lanka/features/auth/widgets/budget_tab_switch.dart';
import 'package:ride_lanka/widgets/primary_button.dart';

class MetaDataScreen extends StatefulWidget {
  const MetaDataScreen({super.key});

  @override
  State<MetaDataScreen> createState() => _MetaDataScreenState();
}

class _MetaDataScreenState extends State<MetaDataScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Consumer<MetaDataProvider>(
      builder: (context, provider, child) {
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
                      const SizedBox(width: 12),
                      const Text(
                        'Ride\nLanka',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Your interests',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 20),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: interests.map((interest) {
                      final selected = provider.selectedInterests.contains(
                        interest,
                      );

                      return GestureDetector(
                        onTap: () {
                          provider.toggleInterest(interest);
                        },

                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),

                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.lowPrimaryColor
                                : AppColors.chipBackground,

                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Text(
                            interest,
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Travel Style',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 20),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: travelStyles.map((style) {
                      final selected = provider.travelType == style;

                      return GestureDetector(
                        onTap: () {
                          provider.setTravelType(style);
                        },

                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),

                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.lowPrimaryColor
                                : AppColors.chipBackground,

                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Text(
                            style,
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Budget Preference',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 20),

                  BudgetTabSwitch(
                    values: const ['Low', 'Medium', 'Premium'],
                    onToggleCallback: (index) {
                      provider.setBudget(['Low', 'Medium', 'Premium'][index]);
                    },
                  ),

                  const Spacer(),

                  provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : PrimaryButton(
                          buttonText: 'Continue',
                          onPressed: provider.isValid
                              ? () => provider.saveUser(context)
                              : null,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
