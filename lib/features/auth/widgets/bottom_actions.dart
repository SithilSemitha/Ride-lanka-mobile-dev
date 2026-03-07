import 'package:flutter/material.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';

class BottomActions extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onPressed;
  const BottomActions({super.key, required this.title, required this.actionText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            actionText,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.forgotPasswordText,
            ),
          ),
        ),
      ],
    );
  }
}
