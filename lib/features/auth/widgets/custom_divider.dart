import 'package:flutter/material.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.dividerColor, thickness: 1)),
        SizedBox(width: 10),
        Text(
          'or login with ',
          style: TextStyle(
            color: AppColors.dividerText,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 10),
        Expanded(child: Divider(color: AppColors.dividerColor, thickness: 1)),
      ],
    );
  }
}
