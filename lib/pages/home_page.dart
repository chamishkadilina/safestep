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

// HomePage UI Widget Tree
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Background Cover Image
          background(size.height, size.width),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Top Icons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Side Bar
                      sideBar(),

                      // Side Dummy Icons
                      Row(
                        children: [
                          dummyIcon(icon: Icons.shield),
                          SizedBox(width: size.width * 0.03),
                          dummyIcon(icon: Icons.edit_notifications_sharp),
                          SizedBox(width: size.width * 0.03),
                          dummyIcon(icon: Icons.share_rounded),
                          SizedBox(width: size.width * 0.03),
                          dummyIcon(icon: Icons.access_alarm_outlined),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.08),

                  // Victim Name
                  victimName(
                    name: 'jhone cena',
                    fontSize: 36,
                  ),
                  SizedBox(height: size.height * 0.03),

                  // Circle Map Button
                  circleMapButton(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GoogleMapPage(initialPosition: currentPosition!),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),

                  // Connected or Disconnetcted Text Indicate
                  textIndicate(fontSize: 24),
                  SizedBox(height: size.height * 0.03),

                  // Utils Empty Box
                  utilsBox(height: size.height / 4),
                  const Spacer(),

                  // privecy policy
                  privecyPolicy(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Background Cover Image
  Widget background(double height_, double widht_) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ig_bgmap.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Side Bar
  Widget sideBar() {
    return Icon(
      Icons.format_list_bulleted,
      color: Colors.grey.shade200,
      size: 36,
    );
  }

  // Dummy Icons
  Widget dummyIcon({IconData? icon}) {
    return Icon(
      icon,
      color: Colors.grey.shade200,
      size: 36,
    );
  }

  // Victim Name
  Widget victimName({required String name, double? fontSize}) {
    return Center(
      child: Text(
        name.toUpperCase(),
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  // Circle map button
  Widget circleMapButton({Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
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
    );
  }

  // Connected or Disconnetcted Text Indicate
  Widget textIndicate({double? fontSize}) {
    return Text(
      "CONNECTED",
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: Colors.blue.shade200,
      ),
    );
  }

  // Utils Empty Box
  Widget utilsBox({double? height}) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withOpacity(0.4),
            ),
          ),
        ),
      ],
    );
  }

  // privecy policy
  Widget privecyPolicy() {
    return Text.rich(
      TextSpan(
        text: 'By using the app, you agree to our ',
        style: TextStyle(
          color: Colors.grey.shade200,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(
              color: Colors.grey.shade200,
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
    );
  }
}
