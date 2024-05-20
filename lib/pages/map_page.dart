import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  static String id = 'map_page';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // back Button
              Align(
                alignment: Alignment.centerLeft,
                child: BackButton(
                  style: ButtonStyle(
                    iconColor: WidgetStatePropertyAll(Colors.white),
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 64),

              Center(
                child: Text(
                  'Show Location on a\nlive map',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
