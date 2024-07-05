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
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await initializeMap());
  }

  // is not ideal to call this method diredctly initstate. therefore we create inintiaize map method
  Future<void> initializeMap() async {
    await fetchLocationUpdates();
    final coordinates = await fetchPolylinePoints();
    genaratePolylinesFromPoints(coordinates);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPosition == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: googlePlex,
                zoom: 13,
              ),
              markers: {
                // current location marker
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  icon: BitmapDescriptor.defaultMarker,
                  position: currentPosition!,
                ),
                // source location marker
                const Marker(
                  markerId: MarkerId('sourceLocation'),
                  icon: BitmapDescriptor.defaultMarker,
                  position: googlePlex,
                ),
                // distination location marker
                const Marker(
                  markerId: MarkerId('distination'),
                  icon: BitmapDescriptor.defaultMarker,
                  position: mountainView,
                ),
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  // get user permission and fetch current location
  Future<void> fetchLocationUpdates() async {
    bool servicesEnabled;
    PermissionStatus permissionGranted;

    // get the user permission
    servicesEnabled = await locationController.serviceEnabled();
    if (servicesEnabled) {
      servicesEnabled = await locationController.requestService();
    } else {
      return;
    }
    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // fetch the current location (listen for location changes)
    locationController.onLocationChanged.listen(
      (currentLocation) {
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

  // fetch polyline points
  Future<List<LatLng>> fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleMapApiKey,
      request: PolylineRequest(
        origin: PointLatLng(googlePlex.latitude, googlePlex.longitude),
        destination: PointLatLng(mountainView.latitude, mountainView.longitude),
        mode: TravelMode.driving,
      ),
    );
    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      debugPrint(result.errorMessage);
      return [];
    }
  }

  // genarate polylines from points
  Future<void> genaratePolylinesFromPoints(
      List<LatLng> polylineCoordinates) async {
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
