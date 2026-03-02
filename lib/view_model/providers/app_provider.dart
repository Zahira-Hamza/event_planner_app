import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc; // Add 'as loc' here

class AppProvider extends ChangeNotifier {
  // Use 'loc.Location' instead of just 'Location'
  var location = loc.Location();
  String locationMessage = '';
  String? eventAddress; // For the human-readable address
  late GoogleMapController mapController;
  LatLng? eventLocation;

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Set<Marker> markers = {
    Marker(
      markerId: const MarkerId('1'),
      position: LatLng(37.42796133580664, -122.085749655962),
    ),
  };

  // Logic to set location and fetch address
  Future<void> setEventLocation(LatLng newEventLocation) async {
    eventLocation = newEventLocation;

    try {
      // Use geocoding to get the address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        newEventLocation.latitude,
        newEventLocation.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        // Format the address to look like the UI
        eventAddress =
            "${place.street}, ${place.administrativeArea}, ${place.country}";
      }
    } catch (e) {
      eventAddress = "Unknown Location";
    }

    notifyListeners();
  }

  Future<void> getLocation() async {
    bool locationPermissionGranted = await _getLocationPermission();
    if (!locationPermissionGranted) return;

    bool locationServiceEnabled = await _locationServiceEnabled();
    if (!locationServiceEnabled) return;

    loc.LocationData locationData = await location
        .getLocation(); // Use loc. prefix
    changeLocationOnMap(locationData);
    setLocationListener();
  }

  Future<bool> _getLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == loc.PermissionStatus.denied) {
      // Use loc. prefix
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == loc.PermissionStatus.granted; // Use loc. prefix
  }

  Future<bool> _locationServiceEnabled() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  void changeLocationOnMap(loc.LocationData locationData) {
    // Use loc. prefix
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: 15,
    );

    markers = {
      Marker(
        markerId: const MarkerId('current_location'),
        position: LatLng(locationData.latitude!, locationData.longitude!),
      ),
    };

    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }

  void setLocationListener() {
    location.changeSettings(
      accuracy: loc.LocationAccuracy.high,
    ); // Use loc. prefix
    location.onLocationChanged.listen((locationData) {
      changeLocationOnMap(locationData);
    });
  }
}
