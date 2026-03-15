import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';
import 'package:ride_lanka/features/home/models/popular_place_model.dart';

class PopularPlaceCard extends StatelessWidget {
  final PopularPlaceModel place;
  const PopularPlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                place.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        place.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Icon(
                        Icons.favorite,
                        color: AppColors.favoriteColor,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.currentLocationText,
                        size: 14,
                      ),
                      Text(" ${place.rating} (${place.reviews})   "),
                      const Icon(
                        CupertinoIcons.location_fill,
                        size: 14,
                        color: AppColors.grey,
                      ),
                      Text(" ${place.distance}"),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.grey,
                        size: 14,
                      ),
                      Text(
                        place.location,
                        style: const TextStyle(
                          color: AppColors.dividerText,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
