import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:map_tap/services/location_service.dart';

class MapTapController extends ChangeNotifier {
  late MapController _mapController;
  late MapOptions _mapOptions = MapOptions();

  Position? _currentLocation;
  late DetermineLocation location;
  bool _isLoading = true;

  MapTapController() {
    location = DetermineLocation();
    locateUser();
    _mapController = MapController();
    updateMapOptions();
  }

  Future<void> locateUser() async {
    _currentLocation = await location.getCurrentLocation();
    try {
      _currentLocation = await location.getCurrentLocation();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _isLoading = false;
      _currentLocation = null;
      notifyListeners();
      return Future.error('Location Not Available');
    }
  }

  void updateMapOptions() {
    _mapOptions = MapOptions(
      zoom: 9.2,
      center: latLng.LatLng(28.704060, 77.102493),
      onTap: (tapPosition, point) {
        print(point);
      },
    );
  }

  MapController get mapController => _mapController;

  MapOptions get mapOptions => _mapOptions;

  bool get isLoading => _isLoading;

  Position? get currentLocation => _currentLocation;
}
