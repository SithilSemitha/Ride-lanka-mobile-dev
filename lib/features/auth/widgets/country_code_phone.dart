import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';

class CountryCodePhone extends StatelessWidget {
  final TextEditingController? controller;
  final bool enabled;

  const CountryCodePhone({super.key, this.controller, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phone Number',
          style: TextStyle(
            color: AppColors.dividerText,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        IntlPhoneField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: 'Phone Number',

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.buttonBorder, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.buttonBorder, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),

            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.errorBorder, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.errorBorder, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          initialCountryCode: 'LK',

          onChanged: (phone) {},
        ),
      ],
    );
  }
}
