class NearbyPlaceModel {
  final String title;
  final String category;
  final String distance;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final bool isFavorite;

  NearbyPlaceModel({
    required this.title,
    required this.category,
    required this.distance,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    this.isFavorite = false,
  });
}