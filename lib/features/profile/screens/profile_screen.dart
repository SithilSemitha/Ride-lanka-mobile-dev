import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';
import 'package:ride_lanka/features/auth/providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bottomNavBackground,
      body: Center(
        child: IconButton(
          onPressed: () {
            Provider.of<AuthController>(
              context,
              listen: false,
            ).signOut(context);
          },
          icon: Icon(Icons.logout, size: 30),
        ),
      ),
    );
  }
}
