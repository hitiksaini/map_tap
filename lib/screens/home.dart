import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_tap/constants/app_theme.dart';
import 'package:map_tap/controllers/map_tap_controller.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart' as latLng;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MapTapTheme.bgBlack,
        title: Text(
          "Map Tap",
          style: MapTapTheme.heading.copyWith(color: MapTapTheme.notWhite),
        ),
      ),
      body: Consumer<MapTapController>(
          builder: (context, mapTapController, child) {
        return mapTapController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : mapTapController.currentLocation == null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Location access was either denied or not available at the moment",
                        textAlign: TextAlign.center,
                        style: MapTapTheme.greyInfoText,
                      ),
                    ),
                  )
                : FlutterMap(
                    mapController: mapTapController.mapController,
                    options: mapTapController.mapOptions,
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                          markers: [
                        latLng.LatLng(
                            mapTapController.currentLocation!.latitude,
                            mapTapController.currentLocation!.longitude),
                      ]
                              .map((point) => Marker(
                                    point: point,
                                    width: 40,
                                    height: 40,
                                    builder: (context) => const Icon(
                                      Icons.location_searching_sharp,
                                      size: 40,
                                      color: Colors.red,
                                    ),
                                  ))
                              .toList())
                    ],
                  );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MapTapTheme.darkGrey,
        child: const Icon(
          Icons.location_searching_outlined,
          color: MapTapTheme.notWhite,
        ),
        onPressed: () {
          final mapTapController = Provider.of<MapTapController>(context, listen: false);
          var currentLat = mapTapController.currentLocation!.latitude;
          var currentLong = mapTapController.currentLocation!.longitude;
          mapTapController.mapController
              .move(latLng.LatLng(currentLat, currentLong), 15.0);
          mapTapSnackBar(context, "Showing current location", false);
        },
      ),
    );
  }
}
