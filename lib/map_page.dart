import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';
import 'package:tasel_frontend/Widgets/result_panels.dart';
import 'package:tasel_frontend/Widgets/scaffold_gradient.dart';
import 'package:tasel_frontend/bloc/show_providers_bloc.dart';
import 'package:tasel_frontend/theme/colors.dart';
import 'package:tasel_frontend/theme/google_map_style.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> controller = Completer();
  TextEditingController search = TextEditingController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.513835, 36.276685),
    zoom: 13.5,
  );

  BitmapDescriptor? customMarkerIcon;
  BitmapDescriptor? userMarkerIcon;

  @override
  void initState() {
    super.initState();
    loadCustomMarker();
  }

  Future<void> loadCustomMarker() async {
    customMarkerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(40, 40)),
      'assets/tasel.png',
    );
    userMarkerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(40, 40)),
      'assets/taselUser.png',
    );
    setState(() {});
  }

  Set<Marker> providersMarkers = {};
  Set<Marker> userMarkers = {};
  Set<String> category = {};
  int _selectedIndex = -1;
  String searchText = '';

  Set<Marker> getMarkers() {
    return {...providersMarkers, ...userMarkers};
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowProvidersBloc()..add(ShowProviders()),
      child: Builder(
        builder: (context) {
          return GradientScaffold(
            body: Stack(
              children: [
                GoogleMap(
                  onTap: (argument) {
                    context.read<ShowProvidersBloc>().add(ShowProviders());
                    setState(() {
                      userMarkers.clear();
                      _selectedIndex = -1;
                    });
                  },
                  onLongPress: (LatLng point) {
                    providersMarkers.add(Marker(
                        markerId: const MarkerId('Point'),
                        position: point,
                        infoWindow: InfoWindow(
                            title: '${point.latitude} , ${point.longitude}')));
                  },
                  fortyFiveDegreeImageryEnabled: true,
                  style: mapBasicStyle,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) async {
                    this.controller.complete(controller);
                  },
                  markers: getMarkers(),
                  polylines: polylines,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: MyTextField(
                              controller: search,
                              suffix: IconButton(
                                  onPressed: () {
                                    context
                                        .read<ShowProvidersBloc>()
                                        .add(ShowProviders());
                                    search.clear();
                                  },
                                  icon: const Icon(Icons.cancel)),
                              title: 'Search',
                              keyboardType: TextInputType.name,
                              ontap: (String search) {
                                setState(() {
                                  searchText = search;
                                });
                                context
                                    .read<ShowProvidersBloc>()
                                    .add(SearchEvent(lexem: searchText));
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.yellow,
                              minimumSize: const Size(56, 70),
                            ),
                            onPressed: _goToMyLocation,
                            child: const Icon(
                              Icons.my_location,
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<ShowProvidersBloc, ShowProvidersState>(
                        builder: (context, state) {
                          if (state is LoadingFetching) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is SuccessShowProviders) {
                            category.clear();
                            providersMarkers.clear();
                            for (var e in state.providers) {
                              category.add(e.category);
                            }

                            return SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: category.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      right: 7,
                                      left: 7,
                                      bottom: 5,
                                    ),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStateProperty
                                            .resolveWith<Color>((states) {
                                          if (states
                                              .contains(WidgetState.pressed)) {
                                            return AppColors.lightYellow;
                                          }
                                          return Colors.white;
                                        }),
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            side: BorderSide(
                                              color: (_selectedIndex == index)
                                                  ? AppColors.darkYellow
                                                  : const Color.fromARGB(
                                                      0, 255, 255, 255),
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selectedIndex = index;
                                        });

                                        context.read<ShowProvidersBloc>().add(
                                            FilterBy(index,
                                                category:
                                                    category.elementAt(index)));
                                        for (var e in state.providers) {
                                          if (e.category ==
                                              category.elementAt(index)) {
                                            providersMarkers.add(
                                              Marker(
                                                markerId:
                                                    MarkerId(e.id.toString()),
                                                position: LatLng(
                                                    e.latitude, e.longitude),
                                                icon: customMarkerIcon!,
                                                infoWindow: InfoWindow(
                                                  title: e.name,
                                                  snippet: e.category,
                                                  onTap: () async {
                                                    Position userPosition =
                                                        await _determinePosition();
                                                    _addUserMarker(
                                                        userPosition);
                                                    _getDirections(
                                                      userPosition.latitude,
                                                      userPosition.longitude,
                                                      e.latitude,
                                                      e.longitude,
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          category.elementAt(index),
                                          style: TextStyle(
                                              color: (_selectedIndex == index)
                                                  ? AppColors.grey
                                                  : AppColors.yellow,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (state is ErrorFetchingData) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'There is an Error',
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      context
                                          .read<ShowProvidersBloc>()
                                          .add(ShowProviders());
                                    },
                                    label: const Text('Try Again'),
                                    icon: const Icon(Icons.autorenew_rounded),
                                  ),
                                ],
                              ),
                            );
                          } else if (state is SearchResutl) {
                            providersMarkers.clear();
                            _selectedIndex = -1;

                            for (var e in state.providers) {
                              providersMarkers.add(
                                Marker(
                                  markerId: MarkerId(e.id.toString()),
                                  position: LatLng(e.latitude, e.longitude),
                                  icon: customMarkerIcon!,
                                  infoWindow: InfoWindow(
                                    title: e.name,
                                    snippet: e.category,
                                    onTap: () async {
                                      Position userPosition =
                                          await _determinePosition();
                                      _addUserMarker(userPosition);
                                      _getDirections(
                                        userPosition.latitude,
                                        userPosition.longitude,
                                        e.latitude,
                                        e.longitude,
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                            return Expanded(
                              child: ListView.builder(
                                itemCount: state.providers.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: 80,
                                    child: ResultLocationPanel(
                                      name: state.providers[index].name,
                                      image:
                                          state.providers[index].profileImage,
                                      id: state.providers[index].id,
                                      longitude:
                                          state.providers[index].longitude,
                                      latitude: state.providers[index].latitude,
                                      onTap: () {
                                        _goToProviderLocation(
                                            state.providers[index].latitude,
                                            state.providers[index].longitude,
                                            state.providers[index].name);
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (state is FilterResutl) {
                            providersMarkers.clear();

                            for (var e in state.providers) {
                              providersMarkers.add(
                                Marker(
                                  markerId: MarkerId(e.id.toString()),
                                  position: LatLng(e.latitude, e.longitude),
                                  icon: customMarkerIcon!,
                                  infoWindow: InfoWindow(
                                    title: e.name,
                                    snippet: e.category,
                                    onTap: () async {
                                      Position userPosition =
                                          await _determinePosition();
                                      _addUserMarker(userPosition);
                                      _getDirections(
                                        userPosition.latitude,
                                        userPosition.longitude,
                                        e.latitude,
                                        e.longitude,
                                      );
                                    },
                                  ),
                                ),
                              );
                            }

                            return SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: category.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      right: 7,
                                      left: 7,
                                      bottom: 5,
                                    ),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStateProperty
                                            .resolveWith<Color>((states) {
                                          if (states
                                              .contains(WidgetState.pressed)) {
                                            return AppColors.lightYellow;
                                          }
                                          return Colors.white;
                                        }),
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            side: BorderSide(
                                              color: (_selectedIndex == index)
                                                  ? AppColors.darkYellow
                                                  : const Color.fromARGB(
                                                      0, 255, 255, 255),
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        context.read<ShowProvidersBloc>().add(
                                            FilterBy(index,
                                                category:
                                                    category.elementAt(index)));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          category.elementAt(index),
                                          style: TextStyle(
                                              color: (_selectedIndex == index)
                                                  ? AppColors.grey
                                                  : AppColors.yellow,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _goToProviderLocation(
      double latitude, double longitude, String name) async {
    final GoogleMapController controller = await this.controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.5,
    )));
  }

  Future<void> _goToMyLocation() async {
    Position userPosition = await _determinePosition();
    _addUserMarker(userPosition);
    final GoogleMapController controller = await this.controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(userPosition.latitude, userPosition.longitude),
      zoom: 14.5,
    )));
  }

  void _addUserMarker(Position userPosition) {
    userMarkers.clear();
    userMarkers.add(
      Marker(
        markerId: const MarkerId('user_marker'),
        position: LatLng(userPosition.latitude, userPosition.longitude),
        icon: userMarkerIcon!,
        infoWindow: const InfoWindow(
          title: 'Your Location',
        ),
      ),
    );
    setState(() {});
  }

  Set<Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();

  void _getDirections(double startLatitude, double startLongitude,
      double destinationLatitude, double destinationLongitude) async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
          destination: PointLatLng(startLatitude, startLongitude),
          origin: PointLatLng(destinationLatitude, destinationLongitude),
          mode: TravelMode.driving),
      googleApiKey: 'AIzaSyAeLUpyozCjrCIxNBNmwVfCERYrHZh3MbU',
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    polylines.add(
      Polyline(
        polylineId: const PolylineId('polyline'),
        color: AppColors.darkYellow,
        width: 6,
        points: polylineCoordinates,
      ),
    );
    setState(() {});
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
