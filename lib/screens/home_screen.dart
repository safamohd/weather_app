import 'package:flutter/material.dart';
import 'package:weather_app/screens/search_screen.dart';
import 'package:weather_app/screens/weather_screen.dart';


import '../constants/app_colors.dart';
import 'forecast_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _screens = [
    const WeatherScreen(),
    const SearchScreen(),
    const ForecastScreen(),
  ];
  int _currentPageIndex = 0 ;
  final _destinations = const [
     NavigationDestination(icon: Icon(Icons.home_outlined , color: Colors.white,),
        selectedIcon: Icon(Icons.home , color: Colors.white,)
        ,label: ''),
    NavigationDestination(icon: Icon(Icons.search_outlined, color: Colors.white,),
        selectedIcon: Icon(Icons.search, color: Colors.white,)
        ,label: ''),
    NavigationDestination(icon: Icon(Icons.wb_sunny_outlined, color: Colors.white,),
        selectedIcon: Icon(Icons.wb_sunny, color: Colors.white,)
        ,label: ''),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentPageIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          backgroundColor: AppColors.secondaryBlack,
        ),
        child: NavigationBar(destinations: _destinations,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: _currentPageIndex,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (index){
          setState(() {
            _currentPageIndex = index ;
          });
          },

        ),
      ),
    );
  }
}
