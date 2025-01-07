import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/services/api_helper.dart';

Future<void> main()   async {
  await dotenv.load(fileName: ".env");
  // ApiHelper.init();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false
    );
  }
}
