import 'package:flutter/material.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';

class HeaderText extends StatelessWidget {
  final String h1;
  final String h2;
  const HeaderText({super.key, required this.h1, required this.h2});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          h1,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          h2,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
