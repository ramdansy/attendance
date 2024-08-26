import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:project_attendance/core/common/common_color.dart';

import '../../cubit/location_cubit.dart';

class LocationPages extends StatelessWidget {
  const LocationPages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit()..initLocation(),
      child: const LocationPagesContent(),
    );
  }
}

class LocationPagesContent extends StatefulWidget {
  const LocationPagesContent({super.key});

  @override
  State<LocationPagesContent> createState() => _LocationPagesContentState();
}

class _LocationPagesContentState extends State<LocationPagesContent> {
  Position? _currentPosition;
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    context.read<LocationCubit>().initLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state is CurrenLocationLoaded) {
            _currentPosition = state.position;
          }
        },
        builder: (context, state) {
          if (state is CurrenLocationLoaded) {
            return _currentPosition != null
                ? FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialCenter: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                      initialZoom: 20,
                      maxZoom: 23,
                      minZoom: 18,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      ),
                      PolygonLayer(
                        polygons: [
                          Polygon(
                            points: const [
                              LatLng(-6.934550983393263, 107.58240900346597),
                              LatLng(-6.934587593974665, 107.58257060656054),
                              LatLng(-6.93450372245672, 107.58257530042637),
                              LatLng(-6.934475099633686, 107.58241637954083)
                            ],
                            color: CommonColor.primary.withOpacity(.3),
                            borderColor: CommonColor.primary.withOpacity(.5),
                            borderStrokeWidth: 1,
                          ),
                        ],
                      ),
                      CurrentLocationLayer(
                        alignPositionOnUpdate: AlignOnUpdate.always,
                        alignDirectionOnUpdate: AlignOnUpdate.never,
                        style: const LocationMarkerStyle(
                          marker: DefaultLocationMarker(
                            color: CommonColor.primary,
                            child: Icon(Icons.navigation, color: Colors.white),
                          ),
                          markerSize: Size(40, 40),
                          markerDirection: MarkerDirection.heading,
                          showAccuracyCircle: false,
                          showHeadingSector: false,
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text('Undefine Location'),
                  );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
