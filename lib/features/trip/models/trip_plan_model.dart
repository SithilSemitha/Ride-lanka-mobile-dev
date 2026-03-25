import 'package:ride_lanka/features/trip/models/trip_stop_model.dart';

class TripPlanModel {
  final String? id;
  final String userId;
  final String tripName;
  final String tripDate;
  final int stopCount;
  final List<String> favorites;
  final String? source;
  final List<TripStopModel> stops;
  final String? status;
  final String? createdAt;

  TripPlanModel({
    this.id,
    required this.userId,
    required this.tripName,
    required this.tripDate,
    required this.stopCount,
    required this.favorites,
    this.source,
    required this.stops,
    this.status,
    this.createdAt,
  });

  factory TripPlanModel.fromJson(Map<String, dynamic> json) {
    final stopsList = json['stops'] as List<dynamic>? ?? [];
    return TripPlanModel(
      id: json['id'],
      userId: json['user_id'] ?? '',
      tripName: json['trip_name'] ?? '',
      tripDate: json['trip_date'] ?? '',
      stopCount: json['stop_count'] ?? 0,
      favorites: (json['favorites'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      source: json['source'],
      stops: stopsList.map((s) => TripStopModel.fromJson(s as Map<String, dynamic>)).toList(),
      status: json['status'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'trip_name': tripName,
      'trip_date': tripDate,
      'stop_count': stopCount,
      'favorites': favorites,
      'source': source,
      'stops': stops.map((s) => s.toJson()).toList(),
      'status': status,
      'createdAt': createdAt,
    };
  }
}
