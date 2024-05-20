import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade300,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // text
                      Text(
                        'Tap to get\nLocation',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 16),
                      // icon
                      Icon(
                        Icons.location_on,
                        size: 128,
                      ),
                    ],
                  ),
                ),
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 360,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade300,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // icon
                                Icon(
                                  Icons.article_sharp,
                                  size: 128,
                                ),
                                SizedBox(height: 8),
                                // text
                                Text(
                                  'Articals',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 360,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade300,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // connection status
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Connection\nStatus',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),

                                // wifi icon
                                const Icon(
                                  Icons.wifi_sharp,
                                  size: 72,
                                ),
                                const SizedBox(height: 8),
                                // connected indicator
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Connected',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
