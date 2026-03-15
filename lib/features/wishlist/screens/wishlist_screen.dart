import 'package:flutter/material.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';
import 'package:ride_lanka/widgets/custom_search_bar.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bottomNavBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wishlist',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              CustomSearchBar(searchBoxHint: 'Search Wishlist'),
            ],
          ),
        ),
      ),
    );
  }
}
