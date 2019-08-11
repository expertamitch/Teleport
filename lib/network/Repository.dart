import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:teleport/blocs/HomeBloc.dart';
import 'package:teleport/models/CommonResponseModel.dart';
import 'package:teleport/models/LocationModel.dart';
import 'package:teleport/models/RideParamsModel.dart';
import 'package:teleport/models/UserModel.dart';

import 'FirebaseProvider.dart';

class Repository {
  final _firebaseProvider = FirebaseProvider();

  Future<CommonResponseModel> registerViaEmail(UserModel userObj) =>
      _firebaseProvider.registerViaEmail(userObj);

  Future<CommonResponseModel> signUp(UserModel userObj) =>
      _firebaseProvider.signUp(userObj);

  Future<CommonResponseModel> login(String email, String password) =>
      _firebaseProvider.login(email, password);

  Future<CommonResponseModel> logout() => _firebaseProvider.logout();

  Future<CommonResponseModel> updateImage(
          String uid, String filePath, String ext) =>
      _firebaseProvider.updateImage(uid, filePath, ext);

  Future<CommonResponseModel> updateUser(String uid, UserModel userObj) =>
      _firebaseProvider.updateProfile(uid, userObj);

  Future<CommonResponseModel> updateMode(UserModel userObj) =>
      _firebaseProvider.updateMode(userObj);

  Future<CommonResponseModel> getProfile(String uid) =>
      _firebaseProvider.getProfile(uid);

  Future<CommonResponseModel> setRideParams(String uid, UserModel model) =>
      _firebaseProvider.setRideParams(uid, model);

  Future<CommonResponseModel> updateLocation(
          LocationModel locationModel, String uid) =>
      _firebaseProvider.updateLocation(locationModel, uid);

//  make singleton to observe

  getDriversByVisibleRegion(
          double leftLongitude, double rightLongitude, HomeBloc homeBloc) =>
      _firebaseProvider.getDriversByVisibleRegion(
          leftLongitude, rightLongitude, homeBloc);

  Future<Object> createRide(RideParamsModel rideParamsModel) =>
      _firebaseProvider.createRide(rideParamsModel);

  Future<Object> saveCard(String token) => _firebaseProvider.saveCard(token);


  currencyListener(HomeBloc homeBloc) =>
      _firebaseProvider.currencyListener(homeBloc);
}
