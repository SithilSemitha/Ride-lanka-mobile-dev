import 'package:flutter/material.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';

class DatePicker extends StatelessWidget {
  final TextEditingController? controller;
  const DatePicker({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date of Birth',
          style: const TextStyle(
            color: AppColors.dividerText,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.buttonBorder, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.buttonBorder, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: 'DD/MM/YYYY',

            suffixIcon: Icon(Icons.event, color: AppColors.grey),
          ),
          readOnly: true,
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              // Handle selected date
              controller?.text =
                  '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
            }
          },
        ),
      ],
    );
  }
}
