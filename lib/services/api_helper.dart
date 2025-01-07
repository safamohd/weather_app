import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;

import '/constants/constants.dart';
import '/models/hourly_weather.dart';
import '/models/weather.dart';
import '/models/weekly_weather.dart';
import '/services/geolocator.dart';
import '/utils/logging.dart';


// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port) => true; // Trust all certificates
//   }
// }
@immutable
class ApiHelper{

  static const baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const weeklyWeatherUrl =
      'https://api.open-meteo.com/v1/forecast?current=&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto';
  static double lat = 0.0 ;
  static double lon = 0.0 ;
  static final dio = Dio();

  // static void init() {
  //   HttpOverrides.global = MyHttpOverrides(); // Enable SSL bypass globally
  // }

  static Future<void> fetchLocation() async {
  final location = await getLocation();
  lat = location.latitude ;
  lon = location.longitude ;
}


  //* Current Weather
  static Future<Weather> getCurrentWeather() async {
    await fetchLocation();
    final url = _constructWeatherUrl();
    final response = await _fetchData(url);
    return Weather.fromJson(response);
  }

  //* Hourly Weather
  static Future<HourlyWeather> getHourlyForecast() async {
    await fetchLocation();
    final url = _constructForecastUrl();
    final response = await _fetchData(url);
    return HourlyWeather.fromJson(response);
  }

  //* Weekly weather
  static Future<WeeklyWeather> getWeeklyForecast() async {
    await fetchLocation();
    final url = _constructWeeklyForecastUrl();
    final response = await _fetchData(url);
    return WeeklyWeather.fromJson(response);
  }

  //* Weather by City Name
  static Future<Weather> getWeatherByCityName({
    required String cityName,
  }) async {
    final url = _constructWeatherByCityUrl(cityName);
    final response = await _fetchData(url);
    return Weather.fromJson(response);
  }


  static String _constructWeatherUrl() =>
      '$baseUrl/weather?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

  static String _constructForecastUrl() =>
      '$baseUrl/forecast?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

  static String _constructWeatherByCityUrl(String cityName) =>
      '$baseUrl/weather?q=$cityName&units=metric&appid=${Constants.apiKey}';

  static String _constructWeeklyForecastUrl() =>
      '$weeklyWeatherUrl&latitude=$lat&longitude=$lon';


 static Future<Map<String,dynamic>> _fetchData(String url)  async {
   try{
     final response = await dio.get(url);
     if(response.statusCode==200) {
       return response.data;
     }else{
       printWarning('Faild to load data : ${response.statusCode}');
       throw Exception('faild to load data');
     }

   }catch(e){
     printWarning('Error fetching data from $url: $e');
     throw Exception('Error fetching data');
   }
 }


}