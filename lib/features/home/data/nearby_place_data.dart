import 'package:ride_lanka/features/home/models/nearby_place_model.dart';

class NearbyPlaceData {
  final List<NearbyPlaceModel> places = [
    NearbyPlaceModel(
      title: 'Sri Dalada Maligawa',
      category: 'Culture',
      distance: '125 km',
      rating: 4.5,
      reviewsCount: 120,
      imageUrl:
          'https://bpu-images-v1.s3.eu-north-1.amazonaws.com/uploads/1721634681262_Sri%20Dalada%20Maligawa%201.jpg',
    ),
    NearbyPlaceModel(
      title: 'Yala National Park',
      category: 'Wildlife',
      distance: '15 km',
      rating: 4.7,
      reviewsCount: 85,
      imageUrl:
          'https://adventuresnolimits.com/wp-content/uploads/2023/05/Yala_National_Park_Sri_Lanka_2012-przerobione.jpg',
    ),
    NearbyPlaceModel(
      title: 'Ravana Falls',
      category: 'Waterfall',
      distance: '25 km',
      rating: 4.8,
      reviewsCount: 200,
      imageUrl:
          'https://www.lovesrilanka.org/wp-content/uploads/2020/04/LS_RavanaFalls_Mob_800x1000.jpg',
    ),
  ];
}
