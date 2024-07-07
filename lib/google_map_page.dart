import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tasel_frontend/theme/colors.dart';

class GoogleMapPage extends StatefulWidget {
  final double lat;
  final double lng;
  const GoogleMapPage({super.key, required this.lat, required this.lng});

  @override
  State<GoogleMapPage> createState() => GoogleMapPageState();
}

class GoogleMapPageState extends State<GoogleMapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  LocationData? currentLocation;
  List<LatLng> polylineCoordinates = [];
  BitmapDescriptor? providerMarkerIcon;
  BitmapDescriptor? userMarkerIcon;
  late StreamSubscription<LocationData> locationSubscription;

  @override
  void initState() {
    super.initState();
    _setCustomMarkerIcons();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    locationSubscription.cancel();
    super.dispose();
  }

  Future<void> _setCustomMarkerIcons() async {
    providerMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(40, 40)),
      'assets/tasel.png',
    );
    userMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(40, 40)),
      'assets/taselUser.png',
    );
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentLocation = await location.getLocation();
    locationSubscription =
        location.onLocationChanged.listen((LocationData locationData) {
      setState(() {
        currentLocation = locationData;
      });
      _getPolyline();
      _updateCameraPosition();
    });
  }

  Future<void> _getPolyline() async {
    if (currentLocation == null) return;
    PolylinePoints polylinePoints = PolylinePoints();

    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: 'AIzaSyAeLUpyozCjrCIxNBNmwVfCERYrHZh3MbU',
        request: PolylineRequest(
          origin: PointLatLng(
              currentLocation!.latitude!, currentLocation!.longitude!),
          destination: PointLatLng(widget.lat, widget.lng),
          mode: TravelMode.driving,
        ),
      );

      if (result.points.isNotEmpty) {
        setState(() {
          polylineCoordinates = result.points
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();
        });
      } else {
        print('No points found in the result');
      }
    } catch (e) {
      print('Error getting polyline: $e');
    }
  }

  Future<void> _updateCameraPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        zoom: 14.5,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              buildingsEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 14.5,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  points: polylineCoordinates,
                  color: AppColors.darkYellow,
                  width: 6,
                ),
              },
              markers: {
                Marker(
                  markerId: MarkerId('user'),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  icon: userMarkerIcon ?? BitmapDescriptor.defaultMarker,
                ),
                Marker(
                  markerId: MarkerId('destination'),
                  position: LatLng(widget.lat, widget.lng),
                  icon: providerMarkerIcon ?? BitmapDescriptor.defaultMarker,
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
    );
  }
}
