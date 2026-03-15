import 'package:flutter/material.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final String searchBoxHint;
  const CustomSearchBar({super.key, required this.searchBoxHint});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.searchBoxBorder, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10, top: 13),
                prefixIcon: const Icon(Icons.search),
                hintText: searchBoxHint,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
