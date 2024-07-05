// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:tasel_frontend/theme/colors.dart';
// import 'package:tasel_frontend/theme/google_map_style.dart';

// class GoogleMapPage extends StatefulWidget {
//   const GoogleMapPage({super.key});

//   @override
//   State<GoogleMapPage> createState() => GoogleMapPageState();
// }

// class GoogleMapPageState extends State<GoogleMapPage> {
//   final Completer<GoogleMapController> _controller = Completer();

//   static const LatLng sourceLocation = LatLng(33.5138319, 36.2765641);
//   static const LatLng destination = LatLng(33.5003826, 36.2533452);

//   List<LatLng> polylineCoordinates = [];

//   @override
//   void initState() {
//     super.initState();
//     getPolyPoint();
//   }

//   void getPolyPoint() async {
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       googleApiKey: 'AIzaSyAeLUpyozCjrCIxNBNmwVfCERYrHZh3MbU',
//       request: PolylineRequest(
//         origin: PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
//         destination:
//             PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
//         mode: TravelMode.driving,
//       ),
//     );

//     print('the result is : ');
//     print(result);

//     if (result.points.isNotEmpty) {
//       polylineCoordinates = result.points
//           .map((point) => LatLng(point.latitude, point.longitude))
//           .toList();
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         style: mapBasicStyle,
//         buildingsEnabled: true,
//         myLocationButtonEnabled: true,
//         myLocationEnabled: true,
//         initialCameraPosition: const CameraPosition(
//           target: sourceLocation,
//           zoom: 14.5,
//         ),
//         polylines: {
//           Polyline(
//             polylineId: const PolylineId('route'),
//             points: polylineCoordinates,
//             color: AppColors.darkYellow,
//             width: 6,
//           ),
//         },
//         markers: {
//           const Marker(
//             markerId: MarkerId('source'),
//             position: sourceLocation,
//           ),
//           const Marker(
//             markerId: MarkerId('destination'),
//             position: destination,
//           ),
//         },
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//     );
//   }
// }
