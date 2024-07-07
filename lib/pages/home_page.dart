import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:safestep/pages/google_map_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final locationController = Location();
  LatLng? currentPosition;

  // fetch the current location at the very begining
  @override
  void initState() {
    super.initState();
    fetchLocationUpdates();
  }

  // Method to get user permission and fetch the current location
  Future<void> fetchLocationUpdates() async {
    bool servicesEnabled;
    PermissionStatus permissionGranted;

    // Check if location services are enabled
    servicesEnabled = await locationController.serviceEnabled();
    if (!servicesEnabled) {
      servicesEnabled = await locationController.requestService();
      if (!servicesEnabled) {
        return;
      }
    }

    // Check and request location permission
    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Listen for location changes and update the current position
    locationController.onLocationChanged.listen(
      (currentLocation) async {
        if (currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          setState(() {
            currentPosition = LatLng(
              currentLocation.latitude!,
              currentLocation.longitude!,
            );
          });
          print(currentPosition);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // background cover image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/ig_bgmap.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // my safe bar
                const SizedBox(height: 48),
                //icon row bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // side bar icon (icon 1)
                    Icon(
                      Icons.format_list_bulleted,
                      color: Colors.grey.shade200,
                      size: 36,
                    ),

                    // right side util icons
                    Row(
                      children: [
                        // icon 1
                        Icon(
                          Icons.shield,
                          color: Colors.grey.shade200,
                          size: 36,
                        ),
                        const SizedBox(width: 16),

                        // icon 2
                        Icon(
                          Icons.edit_notifications_sharp,
                          color: Colors.grey.shade200,
                          size: 36,
                        ),
                        const SizedBox(width: 16),

                        // share icon (icon 4)
                        Icon(
                          Icons.share_rounded,
                          color: Colors.grey.shade200,
                          size: 36,
                        ),
                        const SizedBox(width: 16),

                        // icon 4
                        Icon(
                          Icons.access_alarm_outlined,
                          color: Colors.grey.shade200,
                          size: 36,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 64),

                // victim name
                const Center(
                  child: Text(
                    "ADOLF HITLER",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // to go map circle button. Todo:(bg shaded circles, loading indicate, center map icon)
                GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoogleMapPage(
                                initialPosition: currentPosition!),
                          ),
                        );
                      },
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // bg circle with opacity 0.2
                      Container(
                        height: 256,
                        width: 256,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),

                      // bg circle with opacity 0.4
                      Container(
                        height: 208,
                        width: 208,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),

                      // go to map button with icon
                      Container(
                        height: 160,
                        width: 160,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          'assets/icons/ic_map.png',
                          scale: 4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // connected or disconnetcted indicate text
                Text(
                  "CONNECTED",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade200,
                  ),
                ),
                const SizedBox(height: 48),

                // utils bar todo:(victim imformations, get emergency call.. etc upto 4 things)
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                // privecy policy
                Text.rich(
                  TextSpan(
                    text: 'By using the app, you agree to our ',
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      // fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          // fontSize: 16,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          decorationColor: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: ' & ',
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          // fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          // fontSize: 16,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          decorationColor: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          // fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
