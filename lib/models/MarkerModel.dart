import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel {
  String title;
  String id;
  double lat;
  double lng;
  BitmapDescriptor markerIcon;

  MarkerModel(this.title, this.id, this.lat, this.lng, this.markerIcon);


}
