import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Widgets/Round_text_field.dart';
import '../Widgets/famous_city_tile.dart';
import '../Widgets/location_icon.dart';
import '../constants/text_styles.dart';
import '../view/famous_cities_view.dart';
import '../view/gradient_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller ;
  bool isPressed = false ;
  String cityname = '';

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
    _controller.addListener(() {
      // Check if the text field is empty, if it is, reset isPressed to false
      if (_controller.text.isEmpty) {
        setState(() {
          isPressed = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(children:
          [const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Align(
                alignment: Alignment.center,
                child: Text(
                  'Pick Location',
                  style: TextStyles.h1,
                ),
              ),

              SizedBox(height: 20),

              // Page subtitle
              Text(
                'Find the area or city that you want to know the detailed weather info at this time',
                style: TextStyles.subtitleText,
                textAlign: TextAlign.center,
              ),
            ],

          ),
            // Page title
            const SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: RoundTextField(
                    controller: _controller  ,
                  ),
                ),
                const SizedBox(width: 15,),
                GestureDetector(
                    onTap: (){
                      setState(() {
                        cityname = _controller.text;
                        isPressed = true ;
                      });
                    },
                    child: const LocationIcon()),
              ],
            ),
            const SizedBox(height: 30,),
            isPressed ? Center(child: FamousCityTile(city: cityname, index: 0)) :  const FamousCitiesView()
          ]

      ),
    );
  }
}
