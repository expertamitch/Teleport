import 'dart:convert';

import 'package:teleport/common_utils/CodeConstants.dart';

import 'RideParamsModel.dart';

class UserModel {
  String id;
  String firstName;
  String lastName;
  String nickName;
  String phoneNumber;
  String email;
  String password;
  String image;
  bool rider;
  RideParamsModel rideParams;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.nickName,
      this.email,
      this.phoneNumber,
      this.image,
      this.rider,
      this.rideParams});

  @override
  String toString() {
    return JsonCodec().encode({
      CodeConstants.FIELD_ID: id,
      CodeConstants.FIELD_FIRSTNAME: firstName,
      CodeConstants.FIELD_LASTNAME: lastName,
      CodeConstants.FIELD_NICKNAME: nickName,
      CodeConstants.FIELD_EMAIL: email,
      CodeConstants.FIELD_PHONENUMBER: phoneNumber,
      CodeConstants.FIELD_IMAGE: image,
      CodeConstants.FIELD_RIDER: rider,
      CodeConstants.FIELD_RIDE_PARAMS: rideParams.toString(),
    });
  }

  static UserModel stringToObject(String json) {
    var data = JsonCodec().decode(json) as Map<String, dynamic>;
    return UserModel.fromJson(data);
  }

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) return;
    if (json[CodeConstants.FIELD_ID] == null) {
      id = null;
    } else {
      id = json[CodeConstants.FIELD_ID];
    }
    if (json[CodeConstants.FIELD_IMAGE] == null) {
      image = null;
    } else {
      image = json[CodeConstants.FIELD_IMAGE];
    }
    if (json[CodeConstants.FIELD_FIRSTNAME] == null) {
      firstName = null;
    } else {
      firstName = json[CodeConstants.FIELD_FIRSTNAME];
    }

    if (json[CodeConstants.FIELD_LASTNAME] == null) {
      lastName = null;
    } else {
      lastName = json[CodeConstants.FIELD_LASTNAME];
    }
    if (json[CodeConstants.FIELD_EMAIL] == null) {
      email = null;
    } else {
      email = json[CodeConstants.FIELD_EMAIL];
    }
    if (json[CodeConstants.FIELD_NICKNAME] == null) {
      nickName = null;
    } else {
      nickName = json[CodeConstants.FIELD_NICKNAME];
    }
    if (json[CodeConstants.FIELD_PHONENUMBER] == null) {
      phoneNumber = null;
    } else {
      phoneNumber = json[CodeConstants.FIELD_PHONENUMBER];
    }

    if (json[CodeConstants.FIELD_RIDER] == null) {
      rider = true;
    } else {
      rider = json[CodeConstants.FIELD_RIDER];
    }
    try {
      rideParams = json[CodeConstants.FIELD_RIDE_PARAMS] != null
          ? RideParamsModel.fromJson(json[CodeConstants.FIELD_RIDE_PARAMS])
          : null;
    } catch (exc) {
      if (json[CodeConstants.FIELD_RIDE_PARAMS] != null) {
        var model = RideParamsModel();
        var map = JsonCodec().decode(json[CodeConstants.FIELD_RIDE_PARAMS]);
        model.minRidePrice = map[CodeConstants.FIELD_MIN_RIDE_PRICE];
        model.nickName = map[CodeConstants.FIELD_NICKNAME];
        model.minRideLength = map[CodeConstants.FIELD_MIN_RIDE_LENGTH];
        model.nextTimeBlocLength =
            map[CodeConstants.FIELD_NEXT_TIME_BLOC_LENGTH];
        model.nextTimeBlocPrice = map[CodeConstants.FIELD_NEXT_TIME_BLOC_PRICE];
        model.currency = map[CodeConstants.FIELD_CURRENCY];
        rideParams = model;
      } else {
        rideParams = null;
      }
    }
  }

  Map<String, dynamic> getMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data[CodeConstants.FIELD_ID] = this.id;

    if (this.firstName != null)
      data[CodeConstants.FIELD_FIRSTNAME] = this.firstName;

    if (this.lastName != null)
      data[CodeConstants.FIELD_LASTNAME] = this.lastName;

    if (this.email != null) data[CodeConstants.FIELD_EMAIL] = this.email;

    if (this.nickName != null)
      data[CodeConstants.FIELD_NICKNAME] = this.nickName;

    if (this.phoneNumber != null)
      data[CodeConstants.FIELD_PHONENUMBER] = this.phoneNumber;

    if (this.image != null) data[CodeConstants.FIELD_IMAGE] = this.image;
    if (this.rider != null) data[CodeConstants.FIELD_RIDER] = this.rider;
    if (this.rideParams != null) {
      data[CodeConstants.FIELD_RIDE_PARAMS] = this.rideParams.getMap();
    }
    return data;
  }
}
