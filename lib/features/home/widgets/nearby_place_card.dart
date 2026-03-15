import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';
import 'package:ride_lanka/features/home/models/nearby_place_model.dart';

class NearbyPlaceCard extends StatelessWidget {
  final NearbyPlaceModel place;

  const NearbyPlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              place.imageUrl,
              height: 350,
              width: 220,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 12,
            right: 12,
            child: CircleAvatar(
              backgroundColor: Colors.black26,
              child: Icon(
                place.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: place.isFavorite
                    ? AppColors.favoriteColor
                    : AppColors.white,
              ),
            ),
          ),

          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.white.withOpacity(0.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        place.category,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            place.distance,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              Text("${place.rating} (${place.reviewsCount})"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
