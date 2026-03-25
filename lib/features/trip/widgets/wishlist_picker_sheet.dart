import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ride_lanka/features/home/providers/home_provider.dart';
import 'package:ride_lanka/features/wishlist/providers/wishlist_provider.dart';
import 'package:ride_lanka/features/trip/providers/trip_provider.dart';
import 'package:ride_lanka/features/trip/models/trip_stop_model.dart';
import 'package:ride_lanka/features/home/models/explore_place_model.dart';

class WishlistPickerSheet extends StatelessWidget {
  const WishlistPickerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
             Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add from Wishlist',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer2<WishlistProvider, HomeProvider>(
                builder: (context, wishlistProvider, homeProvider, _) {
                  if (wishlistProvider.favoriteIds.isEmpty) {
                    return const Center(child: Text('Your wishlist is empty.'));
                  }

                  // Find all wishlisted explore places
                  final wishlistPlaces = homeProvider.allExplorePlaces.where(
                    (p) => wishlistProvider.favoriteIds.contains(p.id)
                  ).toList();

                  if (wishlistPlaces.isEmpty) {
                    return const Center(child: Text('No suitable places found in wishlist.'));
                  }

                  return ListView.builder(
                    itemCount: wishlistPlaces.length,
                    itemBuilder: (context, index) {
                      final place = wishlistPlaces[index];
                      // Check if already added
                      final isAdded = context.watch<TripProvider>().currentStops.any((s) => s.placeId == place.id);

                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            place.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(width: 50, height: 50, color: Colors.grey),
                          ),
                        ),
                        title: Text(place.title),
                        subtitle: Text(place.snippet, maxLines: 1, overflow: TextOverflow.ellipsis),
                        trailing: IconButton(
                          icon: Icon(
                            isAdded ? Icons.check_circle : Icons.add_circle_outline,
                            color: isAdded ? Colors.green : const Color(0xFF00A3C4),
                          ),
                          onPressed: isAdded ? null : () => _addPlaceToTrip(context, place),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addPlaceToTrip(BuildContext context, ExplorePlaceModel place) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    double? lat;
    double? lng;
    try {
      List<Location> locations = await locationFromAddress("\${place.title}, Sri Lanka");
      if (locations.isNotEmpty) {
        lat = locations.first.latitude;
        lng = locations.first.longitude;
      }
    } catch (_) {
      lat = 7.8731 + (place.id.hashCode % 100) / 100.0;
      lng = 80.7718 + (place.title.hashCode % 100) / 100.0;
    }

    final stop = TripStopModel(
      stopOrder: context.read<TripProvider>().currentStops.length + 1,
      name: place.title,
      description: place.content,
      category: place.snippet.isNotEmpty ? place.snippet : 'Attraction',
      searchQuery: place.title,
      placeId: place.id,
      photoUrl: place.imageUrl,
      lat: lat,
      lng: lng,
    );

    if (context.mounted) {
      context.read<TripProvider>().addStop(stop);
      Navigator.pop(context); // close dialog
    }
  }
}
