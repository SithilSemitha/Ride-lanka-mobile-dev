import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ride_lanka/features/home/models/explore_place_model.dart';
import 'package:ride_lanka/features/home/providers/home_provider.dart';
import 'package:ride_lanka/features/trip/providers/trip_provider.dart';
import 'package:ride_lanka/features/trip/models/trip_stop_model.dart';

class DestinationSearchDelegate extends SearchDelegate<void> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    final homeProvider = context.read<HomeProvider>();
    final allPlaces = homeProvider.allExplorePlaces;

    final results = allPlaces.where((place) {
      return place.title.toLowerCase().contains(query.toLowerCase()) ||
             place.snippet.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (results.isEmpty) {
      return const Center(child: Text('No destinations found.'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final place = results[index];
        return ListTile(
          leading: const Icon(Icons.place, color: Colors.grey),
          title: Text(place.title),
          subtitle: Text(place.snippet, maxLines: 1, overflow: TextOverflow.ellipsis),
          onTap: () => _handleSelection(context, place),
        );
      },
    );
  }

  Future<void> _handleSelection(BuildContext context, ExplorePlaceModel place) async {
    // Show loading indicator
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
    } catch (e) {
      // Ignore geocoding errors for mock places, fallback to null or center SL
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
      Navigator.pop(context); // Close loading
      close(context, null); // Close search
    }
  }
}
