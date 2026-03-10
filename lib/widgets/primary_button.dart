import 'package:flutter/material.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  const PrimaryButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = onPressed == null;

    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: disabled ? Colors.grey : AppColors.lowPrimaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
