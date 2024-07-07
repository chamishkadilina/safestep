import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:safestep/constants.dart';

class GoogleMapPage extends StatefulWidget {
  final LatLng initialPosition;

  const GoogleMapPage({
    required this.initialPosition,
    super.key,
  });

  static String id = 'map_page';

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  final locationController = Location();
  BitmapDescriptor? customIcon1;
  BitmapDescriptor? customIcon2;

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
    // Load the custom icons
    customIcon1 = await BitmapDescriptor.asset(
        const ImageConfiguration(), 'assets/icons/ic_user1.png');
    customIcon2 = await BitmapDescriptor.asset(
        const ImageConfiguration(), 'assets/icons/ic_user2.png');
    setState(() {
      currentPosition = widget.initialPosition;
    });

    if (currentPosition != null) {
      final coordinates = await fetchPolylinePoints();
      generatePolylinesFromPoints(coordinates);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentPosition!,
                zoom: 14,
              ),
              markers: {
                // Current location marker
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  icon: customIcon1!,
                  position: currentPosition!,
                ),

                // Destination location marker
                Marker(
                  markerId: const MarkerId('destination'),
                  icon: customIcon2!,
                  position: mountainView,
                ),
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
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
      color: Colors.blue.shade800,
      points: polylineCoordinates,
      width: 8,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }
}
