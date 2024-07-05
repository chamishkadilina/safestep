import 'package:flutter/material.dart';
import 'package:safestep/pages/home_page.dart';
import 'package:safestep/pages/google_map_page.dart';

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
        GoogleMapPage.id: (context) => const GoogleMapPage(),
      },
    );
  }
}
