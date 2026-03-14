import 'package:ride_lanka/features/home/models/place_model.dart';

class PlaceData {
  final List<PlaceModel> places = [
    PlaceModel(
      title: 'Sri Dalada Maligawa',
      category: 'Culture',
      distance: '125 km',
      rating: 4.5,
      reviewsCount: 120,
      imageUrl:
          'https://w0.peakpx.com/wallpaper/573/779/HD-wallpaper-dalada-maligawa-buddha-iphone-kandy-lanka-mobile-srilanka-srilankan-temple.jpg',
    ),
    PlaceModel(
      title: 'Yala National Park',
      category: 'Wildlife',
      distance: '15 km',
      rating: 4.7,
      reviewsCount: 85,
      imageUrl:
          'https://adventuresnolimits.com/wp-content/uploads/2023/05/Yala_National_Park_Sri_Lanka_2012-przerobione.jpg',
    ),
    PlaceModel(
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
