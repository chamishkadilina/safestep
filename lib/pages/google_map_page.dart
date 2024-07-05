import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:safestep/constants.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});
  static String id = 'map_page';

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  final locationController = Location();

  static const googlePlex = LatLng(37.422131, -122.084801);
  static const mountainView = LatLng(37.386051, -122.083855);

  LatLng? currentPosition;
  Map<PolylineId, Polyline> polylines = {};

  // fetch the current location at the very begining
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initializeMap();
    });
  }

  // is not ideal to call this method diredctly initstate. therefore we create inintiaize map method
  Future<void> initializeMap() async {
    await fetchLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: googlePlex,
                zoom: 13,
              ),
              markers: {
                // Current location marker
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  icon: BitmapDescriptor.defaultMarker,
                  position: currentPosition!,
                ),

                // Destination location marker
                const Marker(
                  markerId: MarkerId('destination'),
                  icon: BitmapDescriptor.defaultMarker,
                  position: mountainView,
                ),
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
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

          // Fetch polyline points after setting the current position
          if (currentPosition != null) {
            final coordinates = await fetchPolylinePoints();
            generatePolylinesFromPoints(coordinates);
          }
        }
      },
    );
  }

  // Method to fetch polyline points between the current location and the destination
  Future<List<LatLng>> fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleMapApiKey,
      request: PolylineRequest(
        origin:
            PointLatLng(currentPosition!.latitude, currentPosition!.longitude),
        destination: PointLatLng(mountainView.latitude, mountainView.longitude),
        mode: TravelMode.driving,
      ),
    );

    // Return the points if available, otherwise return an empty list
    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      debugPrint(result.errorMessage);
      return [];
    }
  }

  // Method to generate polylines from the fetched points
  void generatePolylinesFromPoints(List<LatLng> polylineCoordinates) {
    const id = PolylineId('polyline');

    final polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }
}
