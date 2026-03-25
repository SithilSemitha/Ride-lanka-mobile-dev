import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';
import 'package:ride_lanka/features/trip/providers/trip_provider.dart';
import 'package:ride_lanka/features/trip/widgets/trip_planner_sheet.dart';
import 'package:ride_lanka/features/trip/widgets/destination_search_delegate.dart';
import 'package:ride_lanka/widgets/custom_search_bar.dart';
import 'package:ride_lanka/features/wishlist/widgets/category_filter_row.dart';

class TripPlanScreen extends StatefulWidget {
  const TripPlanScreen({super.key});

  @override
  State<TripPlanScreen> createState() => _TripPlanScreenState();
}

class _TripPlanScreenState extends State<TripPlanScreen> {
  String _selectedCategory = 'All';

  void _showPlannerSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const TripPlannerSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bottomNavBackground,
      body: Stack(
        children: [
          // Interactive Google Map
          Positioned.fill(
            child: Consumer<TripProvider>(
              builder: (context, provider, child) {
                final stops = provider.currentStops
                    .where((s) => s.lat != null && s.lng != null)
                    .toList();

                final markers = stops
                    .map(
                      (s) => Marker(
                        markerId: MarkerId(s.name),
                        position: LatLng(s.lat!, s.lng!),
                        infoWindow: InfoWindow(
                          title: s.name,
                          snippet: s.category,
                        ),
                      ),
                    )
                    .toSet();

                final polyline = Polyline(
                  polylineId: const PolylineId('route'),
                  points: stops.map((s) => LatLng(s.lat!, s.lng!)).toList(),
                  color: Colors.blueAccent,
                  width: 4,
                );

                // Default camera to Sri Lanka center
                final initialCameraPosition = stops.isNotEmpty
                    ? CameraPosition(
                        target: LatLng(stops.first.lat!, stops.first.lng!),
                        zoom: 12,
                      )
                    : const CameraPosition(
                        target: LatLng(7.8731, 80.7718),
                        zoom: 7,
                      );

                return GoogleMap(
                  initialCameraPosition: initialCameraPosition,
                  markers: markers,
                  polylines: stops.length > 1 ? {polyline} : {},
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                );
              },
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios, size: 20),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Plan a Trip',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: DestinationSearchDelegate(),
                      );
                    },
                    child: const AbsorbPointer(
                      child: CustomSearchBar(
                        searchBoxHint: 'Search places to add...',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Filters
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: CategoryFilterRow(
                    selectedCategory: _selectedCategory,
                    onCategoryChanged: (cat) {
                      setState(() {
                        _selectedCategory = cat;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Floating Action Button "Plan Trip"
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: _showPlannerSheet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF00A3C4,
                  ), // Teal color from mockup
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Plan Trip',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
