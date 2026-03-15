import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryItem extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final radius = size.width * 0.07;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: radius,
            backgroundColor: const Color(0xFF5BA3B2),
            child: SvgPicture.asset(
              icon,
              width: radius * 0.85,
              height: radius * 0.85,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: size.width * 0.030,
              fontWeight: FontWeight.w500,
              fontFamily: 'Helvetica1',
            ),
          ),
        ],
      ),
    );
  }
}