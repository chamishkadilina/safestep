import 'package:flutter/material.dart';
import 'package:safestep/pages/artical_page.dart';
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
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        MapPage.id: (context) => const MapPage(),
        ArticalPage.id: (context) => const ArticalPage(),
      },
    );
  }
}
