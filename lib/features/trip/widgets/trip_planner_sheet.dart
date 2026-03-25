import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_lanka/features/trip/providers/trip_provider.dart';
import 'package:ride_lanka/features/trip/widgets/wishlist_picker_sheet.dart';

class TripPlannerSheet extends StatefulWidget {
  const TripPlannerSheet({super.key});

  @override
  State<TripPlannerSheet> createState() => _TripPlannerSheetState();
}

class _TripPlannerSheetState extends State<TripPlannerSheet> {
  bool _isSettingsStep = false;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final tp = context.read<TripProvider>();
    _nameController.text = tp.tripName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: _isSettingsStep
              ? _buildSettingsStep()
              : _buildDestinationsStep(),
        ),
      ),
    );
  }

  Widget _buildDestinationsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Handle
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
        const SizedBox(height: 20),

        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Trip Planner',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
        const SizedBox(height: 20),

        // Add from wishlist
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Destinations',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const WishlistPickerSheet(),
                  ),
                );
              },
              child: const Text(
                'Add from Wishlist',
                style: TextStyle(color: Color(0xFF00A3C4)),
              ),
            ),
          ],
        ),

        // Destinations List
        Consumer<TripProvider>(
          builder: (context, provider, _) {
            if (provider.currentStops.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'No destinations added yet. Search or add from wishlist!',
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.currentStops.length,
              itemBuilder: (context, index) {
                final stop = provider.currentStops[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.menu, color: Colors.grey),
                  title: Text(
                    stop.name,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    stop.category,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                    onPressed: () => provider.removeStop(stop),
                  ),
                );
              },
            );
          },
        ),

        const SizedBox(height: 10),

        // Optimize Button
        Center(
          child: Consumer<TripProvider>(
            builder: (context, provider, _) {
              return ElevatedButton(
                onPressed: provider.isLoading
                    ? null
                    : () async {
                        await provider.optimizeRoute();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A3C4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: provider.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Optimize Route',
                        style: TextStyle(color: Colors.white),
                      ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),

        // Vehicle Setup (Mock)
        Text(
          'Select Vehicle',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildVehicleCard(Icons.pedal_bike, 'Bike'),
            _buildVehicleCard(Icons.directions_car, 'Car'),
            _buildVehicleCard(Icons.airport_shuttle, 'Van'),
            _buildVehicleCard(Icons.directions_bus, 'Bus'),
          ],
        ),

        const SizedBox(height: 30),

        // Next Button
        Center(
          child: ElevatedButton(
            onPressed: () {
              setState(() => _isSettingsStep = true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A3C4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVehicleCard(IconData icon, String label) {
    return Consumer<TripProvider>(
      builder: (context, provider, _) {
        final isSelected = provider.vehicleType == label;
        return GestureDetector(
          onTap: () => provider.setVehicleType(label),
          child: Container(
            width: 70,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF00A3C4)
                    : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: isSelected ? const Color(0xFF00A3C4) : Colors.black87,
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _isSettingsStep = false),
                  child: const Icon(Icons.arrow_back_ios, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Trip Settings',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
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
        const SizedBox(height: 30),

        // Trip Name
        Row(
          children: [
            Text(
              'Trip Name',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                controller: _nameController,
                onChanged: (val) =>
                    context.read<TripProvider>().setTripName(val),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Route Preference
        Row(
          children: [
            Text(
              'Route Preference',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Consumer<TripProvider>(
                builder: (context, provider, _) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: provider.routePreference,
                        items: const [
                          DropdownMenuItem(
                            value: 'shortest',
                            child: Text('Shortest route'),
                          ),
                          DropdownMenuItem(
                            value: 'safest',
                            child: Text('Safest route'),
                          ),
                          DropdownMenuItem(
                            value: 'max_places',
                            child: Text('Max places path'),
                          ),
                        ],
                        onChanged: (val) {
                          if (val != null) provider.setRoutePreference(val);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Accessibility (Mock)
        Text(
          'Accessibility Options',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueAccent.shade100,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.circular(16),
            // We use dashed border visually later if needed, simple solid for now
            gradient: LinearGradient(
              colors: [Colors.teal.shade50, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              _buildMockCheckbox('Avoid steep roads', true),
              _buildMockCheckbox('Avoid narrow roads', true),
              _buildMockCheckbox('Wheelchair-friendly routes', false),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Summary
        Text(
          'Trip Summary',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Consumer<TripProvider>(
          builder: (context, provider, _) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF00A3C4).withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vehicle Type',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            provider.vehicleType,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Route Preference',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            provider.routePreference,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.near_me, size: 14, color: Colors.grey),
                              SizedBox(width: 4),
                              Text(
                                '62.2km',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '92 min',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.eco, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'CO2 saved: ~1.2 kg (18% less)',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 30),

        // Start Trip Button
        Center(
          child: Consumer<TripProvider>(
            builder: (context, provider, _) {
              return ElevatedButton(
                onPressed: provider.isLoading
                    ? null
                    : () async {
                        final authUser =
                            'user123'; // Replace with real auth user ID when integrated
                        final success = await provider.saveCurrentTrip(
                          authUser,
                        );
                        if (success && context.mounted) {
                          Navigator.pop(context); // Close sheet
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Trip Saved successfully!'),
                            ),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A3C4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 14,
                  ),
                ),
                child: provider.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Start Trip',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMockCheckbox(String label, bool isChecked) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isChecked ? Colors.blueAccent : Colors.white,
              border: Border.all(
                color: isChecked ? Colors.blueAccent : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              Icons.remove,
              size: 16,
              color: isChecked ? Colors.white : Colors.transparent,
            ),
          ),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
