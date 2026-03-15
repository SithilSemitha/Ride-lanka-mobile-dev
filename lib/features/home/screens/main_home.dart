import 'package:flutter/material.dart';
import 'package:ride_lanka/core/constants/app_assets.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';
import 'package:ride_lanka/features/home/data/nearby_place_data.dart';
import 'package:ride_lanka/features/home/data/popular_place_data.dart';
import 'package:ride_lanka/features/home/models/category_model.dart';
import 'package:ride_lanka/features/home/widgets/category_item.dart';
import 'package:ride_lanka/features/home/widgets/nearby_place_card.dart';
import 'package:ride_lanka/features/home/widgets/popular_place_card.dart';

const String helvetica1 = 'Helvetica1';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final List<CategoryModel> categories = [
    CategoryModel(label: 'Beach', icon: AppAssets.beachIcon),
    CategoryModel(label: 'Mountain', icon: AppAssets.mountainIcon),
    CategoryModel(label: 'Culture', icon: AppAssets.cultureIcon),
    CategoryModel(label: 'Waterfall', icon: AppAssets.waterfallIcon),
    CategoryModel(label: 'Wildlife', icon: AppAssets.wildlifeIcon),
  ];

  NearbyPlaceData nearbyPlaceData = NearbyPlaceData();
  PopularPlaceData popularPlaceData = PopularPlaceData();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final hPad = size.width * 0.05;

    return Scaffold(
      backgroundColor: AppColors.bottomNavBackground,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              AppAssets.homeTopDesign,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, Thisara',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: size.width * 0.065,
                              fontFamily: helvetica1,
                            ),
                          ),
                          Text(
                            'Ratnapura, Sri Lanka',
                            style: TextStyle(
                              color: AppColors.currentLocationText,
                              fontSize: size.width * 0.038,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        AppAssets.logo,
                        color: AppColors.black,
                        width: size.width * 0.10,
                        height: size.width * 0.10,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.025),

                  Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                left: 10,
                                top: 13,
                              ),
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Search destinations',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: VerticalDivider(
                            color: AppColors.grey,
                            thickness: 1,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.filter_list),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.23),

                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: categories
                        .map(
                          (cat) => CategoryItem(
                            icon: cat.icon,
                            label: cat.label,
                            onTap: () {},
                          ),
                        )
                        .toList(),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.025),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: hPad),
                          child: Text(
                            'Nearby',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 20,
                              fontFamily: helvetica1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        SizedBox(
                          height: size.height * 0.3,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: hPad),
                            scrollDirection: Axis.horizontal,
                            itemCount: nearbyPlaceData.places.length,
                            itemBuilder: (context, index) {
                              return NearbyPlaceCard(
                                place: nearbyPlaceData.places[index],
                              );
                            },
                          ),
                        ),

                        SizedBox(height: size.height * 0.025),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: hPad),
                          child: Text(
                            'Popular',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 20,
                              fontFamily: helvetica1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: hPad),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: popularPlaceData.popularPlaces.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              return PopularPlaceCard(
                                place: popularPlaceData.popularPlaces[index],
                              );
                            },
                          ),
                        ),

                        SizedBox(height: size.height * 0.04),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
