import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:map_tap/services/location_service.dart';
import 'package:map_tap/services/maps_service.dart';

class MapTapController extends ChangeNotifier {
  late MapController _mapController;

  Position? _currentLocation;
  late DetermineLocation location;
  bool _isLoading = true;

  String _addressFromPoint = "";

  MapTapController() {
    location = DetermineLocation();
    locateUser();
    _mapController = MapController();
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

  Future updateMapOptions(latLng.LatLng point) async {
    _addressFromPoint = await MapService.fetchAddressFromPoint(point);
    notifyListeners();
  }

  MapController get mapController => _mapController;

  bool get isLoading => _isLoading;

  Position? get currentLocation => _currentLocation;

  String get addressFromPoint => _addressFromPoint;
}
