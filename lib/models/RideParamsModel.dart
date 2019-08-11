import 'dart:convert';

import 'package:teleport/common_utils/CodeConstants.dart';

class RideParamsModel {
  String nickName;
  String minRidePrice;
  String minRideLength;
  String currency;
  String nextTimeBlocPrice;
  String nextTimeBlocLength;
  double latitude;
  double longitude;

  RideParamsModel(
      {this.nickName,
      this.minRidePrice,
      this.minRideLength,
      this.currency,
      this.nextTimeBlocPrice,
      this.nextTimeBlocLength,
      this.latitude,
      this.longitude});

  RideParamsModel.fromJson(Map<dynamic, dynamic> json) {
    nickName = json[CodeConstants.FIELD_NICKNAME];
    minRidePrice = json[CodeConstants.FIELD_MIN_RIDE_PRICE];
    minRideLength = json[CodeConstants.FIELD_MIN_RIDE_LENGTH];
    currency = json[CodeConstants.FIELD_CURRENCY];
    nextTimeBlocPrice = json[CodeConstants.FIELD_NEXT_TIME_BLOC_PRICE];
    nextTimeBlocLength = json[CodeConstants.FIELD_NEXT_TIME_BLOC_LENGTH];
    latitude = json[CodeConstants.FIELD_LATITUDE];
    longitude = json[CodeConstants.FIELD_LONGITUDE];
  }

  @override
  String toString() {
    return JsonCodec().encode({
      CodeConstants.FIELD_NICKNAME: nickName,
      CodeConstants.FIELD_MIN_RIDE_PRICE: minRidePrice,
      CodeConstants.FIELD_MIN_RIDE_LENGTH: minRideLength,
      CodeConstants.FIELD_NEXT_TIME_BLOC_PRICE: nextTimeBlocPrice,
      CodeConstants.FIELD_NEXT_TIME_BLOC_LENGTH: nextTimeBlocLength,
      CodeConstants.FIELD_CURRENCY: currency,
      CodeConstants.FIELD_LATITUDE: latitude,
      CodeConstants.FIELD_LONGITUDE: longitude
    });
  }

//  static RideParamsModel stringToObject(String json) {
//    var data = JsonCodec().decode(json) as Map<String, dynamic>;
//    return RideParamsModel.fromJson(data);
//  }

  static RideParamsModel stringToObject(String json) {
    final RideParamsModel data = JsonCodec().decode(json);
    return data;
  }

  static RideParamsModel stringToObject1(String json) {
    var data = JsonCodec().decode(json) as Map<String, dynamic>;
    return RideParamsModel.fromJson(data);
  }

  Map<String, dynamic> getMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[CodeConstants.FIELD_NICKNAME] = this.nickName;
    data[CodeConstants.FIELD_MIN_RIDE_PRICE] = this.minRidePrice;
    data[CodeConstants.FIELD_MIN_RIDE_LENGTH] = this.minRideLength;
    data[CodeConstants.FIELD_CURRENCY] = this.currency;
    data[CodeConstants.FIELD_NEXT_TIME_BLOC_PRICE] = this.nextTimeBlocPrice;
    data[CodeConstants.FIELD_NEXT_TIME_BLOC_LENGTH] = this.nextTimeBlocLength;
    data[CodeConstants.FIELD_LATITUDE] = this.latitude;
    data[CodeConstants.FIELD_LONGITUDE] = this.longitude;
    return data;
  }
}
