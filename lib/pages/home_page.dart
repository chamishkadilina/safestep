import 'package:flutter/material.dart';
import 'package:safestep/pages/artical_page.dart';
import 'package:safestep/pages/components/banner_tile.dart';
import 'package:safestep/pages/components/connection_tile.dart';
import 'package:safestep/pages/components/icon_box_tile.dart';
import 'package:safestep/pages/map_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Safe Step',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              //get location button
              BannerTile(
                onTap: () {
                  Navigator.pushNamed(context, MapPage.id);
                },
                icon: Icons.location_on,
                text: 'Tap to get\nLocation',
              ),
              const SizedBox(height: 8),

              // divider
              const SizedBox(
                child: Divider(),
              ),

              // articals + connected indicator
              SizedBox(
                height: 200,
                child: Row(
                  children: [
                    // articals
                    IconBoxTile(
                      onTap: () {
                        Navigator.pushNamed(context, ArticalPage.id);
                      },
                      icon: Icons.article_sharp,
                      text: 'Articals',
                    ),

                    // connection Status
                    const ConnectionTile(
                      icon: Icons.wifi_sharp,
                      text: 'Connected',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
