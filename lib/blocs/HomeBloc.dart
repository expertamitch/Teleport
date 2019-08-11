import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:teleport/models/CurrencyModel.dart';
import 'package:teleport/models/LocationModel.dart';
import 'package:teleport/models/MarkerModel.dart';
import 'package:teleport/models/RideParamsModel.dart';
import 'package:teleport/network/Repository.dart';

import 'BlocBase.dart';
import 'CommonSingleton.dart';

class HomeBloc extends BlocBase {
  var currentLocationId = commonSingleton.id.value;
  Location location;
  var repository = Repository();
  final allMarkersController = BehaviorSubject<Map<String, RideParamsModel>>();

//  final allMarkersController = BehaviorSubject<Map<MarkerId, Marker>>();
  BitmapDescriptor _markerIcon;

  Observable<Map<String, RideParamsModel>> get allMarkers =>
      allMarkersController.stream;

//  currency for conversion
  final currency = BehaviorSubject<Map<String, dynamic>>();

  double lat, lng;

  HomeBloc() {
    location = new Location();

    location.hasPermission().then((has) {
      if (has)
        locationSetup();
      else
        location.requestPermission().then((given) {
          if (given) {
            locationSetup();
          }
        });
    });

    repository.currencyListener(this);
  }

  getDriversByRegion(double startLng, double endLng) {
    repository.getDriversByVisibleRegion(startLng, endLng, this);
  }

  updateCurrentMarker(lat, lng) {
    Map<String, RideParamsModel> markers = <String, RideParamsModel>{};

//    check if app already have markers, then merge current marker so that other do not get affected
    if (allMarkersController.value != null) {
      markers = allMarkersController.value;
    }

    RideParamsModel rideParamsModel = RideParamsModel();
    rideParamsModel.longitude = lng;
    rideParamsModel.latitude = lat;

    markers[commonSingleton.id.value] = rideParamsModel;
    this.lat = lat;
    this.lng = lng;
    allMarkersController.sink.add(markers);
  }

  locationSetup() {
//TODO    test this in background, sometimes location stop updating, may be because it do not found profile bloc

    location.onLocationChanged().listen((LocationData currentLocation) {
      updateCurrentMarker(currentLocation.latitude, currentLocation.longitude);
      if (!commonSingleton.rider.value)
        repository.updateLocation(
            LocationModel(currentLocation.latitude, currentLocation.longitude,
                DateTime.now().toIso8601String()),
            commonSingleton.id.value);
    });

    // Fired whenever a location is recorded
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      updateCurrentMarker(location.coords.latitude, location.coords.longitude);
      print("UPDATING");

      if (!commonSingleton.rider.value)
        repository.updateLocation(
            LocationModel(location.coords.latitude, location.coords.longitude,
                DateTime.now().toIso8601String()),
            commonSingleton.id.value);
    });

    // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
      print("UPDATING");

//      print('[motionchange] - $location');
    });

    // Fired whenever the state of location-services changes.  Always fired at boot
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
//      print('[providerchange] - $event');
    });

    // 2.  Configure the plugin
    //
    bg.BackgroundGeolocation.ready(bg.Config(
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            distanceFilter: 1.0,
            stopOnTerminate: false,
            startOnBoot: true,
            debug: true,
            logLevel: bg.Config.LOG_LEVEL_VERBOSE,
            reset: true))
        .then((bg.State state) {
      if (!state.enabled) {
        ////
        // 3.  Start the plugin.
        //
        bg.BackgroundGeolocation.start();
      }
    });
  }

  @override
  void dispose() {
    allMarkersController.close();
    currency.close();
  }


}
