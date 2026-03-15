import 'package:flutter/material.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';
import 'package:ride_lanka/features/home/screens/main_home.dart';
import 'package:ride_lanka/features/profile/screens/profile_screen.dart';
import 'package:ride_lanka/features/trip/screens/trip_plan_screen.dart';
import 'package:ride_lanka/features/wishlist/screens/wishlist_screen.dart';

class HomeBottomNav extends StatefulWidget {
  const HomeBottomNav({super.key});

  @override
  State<HomeBottomNav> createState() => _HomeBottomNavState();
}

class _HomeBottomNavState extends State<HomeBottomNav> {
  int currentIndex = 0;
  final List<Widget> pages = [
    MainHome(),
    TripPlanScreen(),
    WishlistScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,

        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.grey,
        iconSize: MediaQuery.of(context).size.height * 0.03,
        backgroundColor: AppColors.bottomNavBackground,
        currentIndex: currentIndex,

        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),

        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Trip'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
