class PopularPlaceModel {
  final String id; 
  final String title;
  final String category;
  final String location;
  final String distance;
  final double rating;
  final int reviews;
  final String imageUrl;
  final bool isFavorite; 

  PopularPlaceModel({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.distance,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    this.isFavorite = false,
  });
}