import 'package:flutter/foundation.dart';
import 'package:ride_lanka/features/trip/models/trip_plan_model.dart';
import 'package:ride_lanka/features/trip/models/trip_stop_model.dart';
import 'package:ride_lanka/features/trip/services/trip_service.dart';

class TripProvider extends ChangeNotifier {
  final TripService _tripService = TripService();

  // Current session Builder State
  List<TripStopModel> _currentStops = [];
  String _tripName = 'My Awesome Trip';
  String _routePreference = 'shortest'; // shortest, safest, max_places
  String _vehicleType = 'Car'; // UI decorative for now

  bool _isLoading = false;
  String? _errorMessage;

  // History State
  List<TripPlanModel> _savedTrips = [];

  // Getters
  List<TripStopModel> get currentStops => _currentStops;
  String get tripName => _tripName;
  String get routePreference => _routePreference;
  String get vehicleType => _vehicleType;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<TripPlanModel> get savedTrips => _savedTrips;

  // Setters
  void setTripName(String name) {
    _tripName = name;
    notifyListeners();
  }

  void setRoutePreference(String pref) {
    _routePreference = pref;
    notifyListeners();
  }

  void setVehicleType(String vehicle) {
    _vehicleType = vehicle;
    notifyListeners();
  }

  // Builder Methods
  void addStop(TripStopModel stop) {
    // Avoid duplicates by placeId, or just simple check by name
    if (!_currentStops.any((s) => s.name == stop.name)) {
      _currentStops.add(stop);
      notifyListeners();
    }
  }

  void removeStop(TripStopModel stop) {
    _currentStops.removeWhere((s) => s.name == stop.name);
    notifyListeners();
  }

  void clearBuilder() {
    _currentStops = [];
    _tripName = 'My Awesome Trip';
    _routePreference = 'shortest';
    _vehicleType = 'Car';
    notifyListeners();
  }

  // API Interactions
  Future<void> optimizeRoute() async {
    if (_currentStops.length < 2) return; // Nothing to optimize
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final optimized = await _tripService.reorderStops(
        stops: _currentStops,
        routePreference: _routePreference,
      );
      _currentStops = optimized;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveCurrentTrip(String userId) async {
    if (_currentStops.isEmpty) return false;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final trip = TripPlanModel(
        userId: userId,
        tripName: _tripName,
        tripDate: DateTime.now().toIso8601String(),
        stopCount: _currentStops.length,
        favorites: [],
        stops: _currentStops,
        status: 'Upcoming',
      );
      await _tripService.saveTrip(trip);
      await fetchSavedTrips(); // Refresh the list
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSavedTrips() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _savedTrips = await _tripService.fetchSavedTrips();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
