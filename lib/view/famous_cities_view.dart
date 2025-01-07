import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/famous_city_tile.dart';
import '../models/famous_city.dart';
import '../screens/weather_detail_screen.dart';

class FamousCitiesView extends StatelessWidget {
  const FamousCitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: famousCities.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context , index){
          final city = famousCities[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => WeatherDetailScreen(cityName: city.name))
              );
            },
            child: FamousCityTile(
              index : index ,
              city : city.name
            ),
          );

    });
  }
}
