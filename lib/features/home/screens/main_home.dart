import 'package:flutter/material.dart';
import 'package:ride_lanka/core/constants/app_assets.dart';
import 'package:ride_lanka/core/constants/app_colors.dart';
import 'package:ride_lanka/features/home/data/place_data.dart';
import 'package:ride_lanka/features/home/models/category_model.dart';
import 'package:ride_lanka/features/home/widgets/category_item.dart';
import 'package:ride_lanka/features/home/widgets/place_card.dart';

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

  PlaceData placeData = PlaceData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bottomNavBackground,
      body: Stack(
        children: [
          Image.asset(
            AppAssets.homeTopDesign,
            filterQuality: FilterQuality.high,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
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
                              fontSize: 26,
                              fontFamily: helvetica1,
                            ),
                          ),
                          Text(
                            'Ratnapura, Sri Lanka',
                            style: TextStyle(
                              color: AppColors.currentLocationText,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        AppAssets.logo,
                        color: AppColors.black,
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 320,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 20,
                                top: 13,
                              ),
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.search),
                              ),
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
                          icon: Icon(Icons.filter_list),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: categories
                        .map(
                          (cat) => CategoryItem(
                            icon: cat.icon,
                            label: cat.label,
                            onTap: () => (),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Nearby',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontFamily: helvetica1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: placeData.places.length,
                      itemBuilder: (context, index) {
                        return PlaceCard(place: placeData.places[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
