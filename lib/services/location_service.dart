import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

abstract class ServiceForUserLocation {
  Future getCurrentLocation();
}

class DetermineLocation extends ServiceForUserLocation {
  @override
  Future getCurrentLocation() async {
    Position position;
    try {
      await LocationExtendedFunctions.requestPermission();
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
      // location = await LocationExtendedFunctions.getAddressFromLatLng(
      //     position.latitude, position.longitude);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return null;
    } on SocketException catch (e) {
      debugPrint(e.toString());
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
    return position;
  }
}

class LocationExtendedFunctions {
  LocationExtendedFunctions._();

  static requestPermission() async {
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
  }
}
