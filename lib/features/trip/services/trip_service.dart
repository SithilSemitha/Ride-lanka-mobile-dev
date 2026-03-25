import 'dart:convert';
import 'package:ride_lanka/core/services/api_client.dart';
import 'package:ride_lanka/features/trip/models/trip_plan_model.dart';
import 'package:ride_lanka/features/trip/models/trip_stop_model.dart';

class TripService {
  Future<List<TripStopModel>> reorderStops({
    required List<TripStopModel> stops,
    required String routePreference,
  }) async {
    final response = await ApiClient.post('/api/users/trips/reorder', {
      'stops': stops.map((e) => e.toJson()).toList(),
      'route_preference': routePreference,
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final tripPlanModel = TripPlanModel.fromJson(jsonResponse);
      return tripPlanModel.stops;
    } else {
      throw Exception('Failed to reorder stops.');
    }
  }

  Future<String> saveTrip(TripPlanModel tripPlan) async {
    final response = await ApiClient.post(
      '/api/users/trips',
      tripPlan.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['tripId'] ?? '';
    } else {
      throw Exception('Failed to save trip. \${response.body}');
    }
  }

  Future<void> updateTripStatus(String tripId, String status) async {
    final response = await ApiClient.put('/api/users/trips/$tripId', {
      'status': status,
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to update trip.');
    }
  }

  Future<List<TripPlanModel>> fetchSavedTrips() async {
    final response = await ApiClient.get('/api/users/trips');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final tripsList = jsonResponse['trips'] as List<dynamic>? ?? [];
      return tripsList
          .map((e) => TripPlanModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to fetch user trips.');
    }
  }

  Future<TripStopModel> searchPlace(String query) async {
    final response = await ApiClient.post('/api/users/trips/search-place', {
      'query': query,
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return TripStopModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to search place.');
    }
  }
}
