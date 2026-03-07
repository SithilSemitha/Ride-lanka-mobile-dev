import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onTap;
  const GoogleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          border: Border.all(color: AppColors.buttonBorder),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Brand(Brands.google, size: 25),
            SizedBox(width: 10),
            Text(
              'Continue with Google',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
