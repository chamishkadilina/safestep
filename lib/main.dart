import 'package:flutter/material.dart';
import 'package:safestep/pages/home_page.dart';
import 'package:safestep/pages/map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        MapPage.id: (context) => const MapPage(),
      },
    );
  }
}
