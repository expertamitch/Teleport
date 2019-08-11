import 'dart:convert';

import 'package:teleport/common_utils/CodeConstants.dart';

class LocationModel {
  double latitude;
  double longitude;
  String locationUpdatedTime;

  LocationModel(this.latitude, this.longitude,this.locationUpdatedTime);

  LocationModel.fromJson(Map<dynamic, dynamic> json) {
    latitude = json[CodeConstants.FIELD_LATITUDE];
    longitude = json[CodeConstants.FIELD_LONGITUDE];
    locationUpdatedTime = json[CodeConstants.FIELD_LOCATION_UPDATE_TIME];
  }

  @override
  String toString() {
    return JsonCodec().encode({
      CodeConstants.FIELD_MIN_RIDE_PRICE: latitude,
      CodeConstants.FIELD_MIN_RIDE_LENGTH: longitude,
      CodeConstants.FIELD_LOCATION_UPDATE_TIME: locationUpdatedTime,
    });
  }

  static LocationModel stringToObject(String json) {
    final LocationModel data = JsonCodec().decode(json);
    return data;
  }

  Map<String, dynamic> getMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[CodeConstants.FIELD_LATITUDE] = this.latitude;
    data[CodeConstants.FIELD_LONGITUDE] = this.longitude;
    data[CodeConstants.FIELD_LOCATION_UPDATE_TIME] = this.locationUpdatedTime;
    return data;
  }
}
