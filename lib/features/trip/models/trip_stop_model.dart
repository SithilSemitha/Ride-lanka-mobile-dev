class TripStopModel {
  final int stopOrder;
  final String name;
  final String description;
  final String category;
  final String searchQuery;
  final String? stopNote;
  final String? placeId;
  final double? lat;
  final double? lng;
  final String? photoUrl;
  final String? mapsUrl;
  final double? rating;

  TripStopModel({
    required this.stopOrder,
    required this.name,
    required this.description,
    required this.category,
    required this.searchQuery,
    this.stopNote,
    this.placeId,
    this.lat,
    this.lng,
    this.photoUrl,
    this.mapsUrl,
    this.rating,
  });

  factory TripStopModel.fromJson(Map<String, dynamic> json) {
    return TripStopModel(
      stopOrder: json['stop_order'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      searchQuery: json['search_query'] ?? '',
      stopNote: json['stop_note'],
      placeId: json['place_id'],
      lat: (json['lat'] != null) ? (json['lat'] as num).toDouble() : null,
      lng: (json['lng'] != null) ? (json['lng'] as num).toDouble() : null,
      photoUrl: json['photo_url'],
      mapsUrl: json['maps_url'],
      rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stop_order': stopOrder,
      'name': name,
      'description': description,
      'category': category,
      'search_query': searchQuery,
      'stop_note': stopNote,
      'place_id': placeId,
      'lat': lat,
      'lng': lng,
      'photo_url': photoUrl,
      'maps_url': mapsUrl,
      'rating': rating,
    };
  }
}
