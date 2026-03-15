import 'package:ride_lanka/features/home/models/popular_place_model.dart';

class PopularPlaceData {
  final List<PopularPlaceModel> popularPlaces = [
    PopularPlaceModel(
      id: '1',
      title: "Sigiriya Rock Fortress",
      category: "Historical Site",
      location: "Sigiriya, Sri Lanka",
      distance: "102.2km",
      rating: 4.9,
      reviews: 729,
      imageUrl:
          "https://t3.ftcdn.net/jpg/04/72/15/84/360_F_472158460_EEZxYRnfbPVQHR1NGjkvgZKfiSsWnCri.jpg",
    ),
    PopularPlaceModel(
      id: '2',
      title: "Ravana Falls",
      category: "Waterfall",
      location: "Ella, Sri Lanka",
      distance: "85.5km",
      rating: 4.8,
      reviews: 729,
      imageUrl:
          "https://theportuguesetraveler.com/wp-content/uploads/2024/11/ravana-falls-waterfall-ella-sri-lanka-27.jpg",
    ),
  ];
}
