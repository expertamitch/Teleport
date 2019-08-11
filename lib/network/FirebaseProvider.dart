import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:teleport/blocs/HomeBloc.dart';
import 'package:teleport/common_utils/CodeConstants.dart';
import 'package:teleport/common_utils/SharedPref.dart';
import 'package:teleport/models/CommonResponseModel.dart';
import 'package:teleport/models/CurrencyModel.dart';
import 'package:teleport/models/LocationModel.dart';
import 'package:teleport/models/RideParamsModel.dart';
import 'package:teleport/models/UserModel.dart';
import 'package:teleport/blocs/CommonSingleton.dart';
import 'package:cloud_functions/cloud_functions.dart';

class FirebaseProvider {
//  declarations and initialisations
  static FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<QuerySnapshot> driversStream;
  StreamSubscription<QuerySnapshot> currencyStrem;

//  auth signup
  Future<CommonResponseModel> registerViaEmail(UserModel userObj) async {
    String result = "";
    int code = 200;
    return await _auth
        .createUserWithEmailAndPassword(
            email: userObj.email, password: userObj.password)
        .then((loggedUser) {
      loggedUser.getIdToken().then((token) {
        SharedPref().save(CodeConstants.TOKEN, token);
        commonSingleton.token.value = token;
      });
      UserUpdateInfo updatedUser = UserUpdateInfo();

      return loggedUser.updateProfile(updatedUser).then((updatedUser) {
        code = CodeConstants.CODE_SUCCESS;
        result = loggedUser.uid;
        return CommonResponseModel(code, result);
      }).catchError((error) {
        code = CodeConstants.CODE_EXCEPTION;
        result = error.message;
        return CommonResponseModel(code, result);
      });
    }).catchError((error) {
      code = CodeConstants.CODE_EXCEPTION;
      result = error.message;
      return CommonResponseModel(code, result);
    });
  }

//  db entry
  Future<CommonResponseModel> signUp(UserModel userObj) async {
    return Firestore.instance
        .collection(CodeConstants.COLLECTION_USERS)
        .document(userObj.id)
        .setData(userObj.getMap())
        .then((onValue) {
      return CommonResponseModel(CodeConstants.CODE_SUCCESS, userObj.id);
    }).catchError((error) {
      return CommonResponseModel(CodeConstants.CODE_EXCEPTION, error.message);
    });
  }

//  auth login
  Future<CommonResponseModel> login(String email, String password) async {
    return await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((loggedUser) {
      return loggedUser.getIdToken().then((token) {
        SharedPref().save(CodeConstants.TOKEN, token);
        commonSingleton.token.value = token;
        return CommonResponseModel(CodeConstants.CODE_SUCCESS, loggedUser.uid);
      });
    }).catchError((error) {
      return CommonResponseModel(CodeConstants.CODE_EXCEPTION, error.message);
    });
  }

//  auth logout
  Future<CommonResponseModel> logout() {
    if (!commonSingleton.rider.value) {
      var model = commonSingleton.getUserModel();
      model.rider = true;

      return updateMode(model).then((res) {
        if (res.code == CodeConstants.CODE_SUCCESS) {
          return _auth.signOut().then((val) {
            return CommonResponseModel(CodeConstants.CODE_SUCCESS, "Success");
          }).catchError((error) {
            return CommonResponseModel(
                CodeConstants.CODE_EXCEPTION, error.message);
          });
        } else {
          return CommonResponseModel(CodeConstants.CODE_EXCEPTION, res.data);
        }
      });
    } else
      return _auth.signOut().then((val) {
        return CommonResponseModel(CodeConstants.CODE_SUCCESS, "Success");
      }).catchError((error) {
        return CommonResponseModel(CodeConstants.CODE_EXCEPTION, error.message);
      });
  }

//  update user image in storage
  Future<CommonResponseModel> updateImage(uid, filePath, ext) async {
    final String fileName = uid;

    final StorageReference storageRef = FirebaseStorage.instance
        .ref()
        .child(CodeConstants.STORAGE_USER)
        .child(fileName);

    final StorageUploadTask uploadTask = storageRef.putFile(
      File(filePath),
      StorageMetadata(contentType: 'image' + '/' + ext),
    );

    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);

    return downloadUrl.ref.getDownloadURL().then((url) {
      return CommonResponseModel(CodeConstants.CODE_SUCCESS, url);
    }).catchError((error) {
      return CommonResponseModel(CodeConstants.CODE_EXCEPTION, error.message);
    });
  }

//  update user profile in db
  Future<CommonResponseModel> updateProfile(
      String uid, UserModel userObj) async {
    return Firestore.instance
        .collection(CodeConstants.COLLECTION_USERS)
        .document(uid)
        .updateData(userObj.getMap())
        .then((onValue) {
      return CommonResponseModel(CodeConstants.CODE_SUCCESS, "Success");
    }).catchError((error) {
      return CommonResponseModel(CodeConstants.CODE_EXCEPTION, error.message);
    });
  }

//  get profile
  Future<CommonResponseModel> getProfile(String uid) async {
    return Firestore.instance
        .collection(CodeConstants.COLLECTION_USERS)
        .document(uid)
        .get()
        .then((onValue) {
      return CommonResponseModel(CodeConstants.CODE_SUCCESS, onValue.data);
    }).catchError((error) {
      return CommonResponseModel(CodeConstants.CODE_EXCEPTION, error.message);
    });
  }

//  set or update ride params
  Future<CommonResponseModel> setRideParams(
      String uid, UserModel userModel) async {
    if (userModel.rider) {
      return setRideParamsRider(uid, userModel);
    } else
      return setRideParamsDriver(uid, userModel);
  }

//  set ride params for driver
  Future<CommonResponseModel> setRideParamsDriver(
      String uid, UserModel userModel) async {
    return Firestore.instance
        .collection(CodeConstants.COLLECTION_USERS)
        .document(uid)
        .updateData(userModel.getMap())
        .then((onValue) {
      return addToActiveDrivers(userModel);
    }).catchError((error) {
      return CommonResponseModel(CodeConstants.CODE_EXCEPTION, error.message);
    });
  }

//  set ride params for rider
  Future<CommonResponseModel> setRideParamsRider(
      String uid, UserModel userModel) async {
    return Firestore.instance
        .collection(CodeConstants.COLLECTION_USERS)
        .document(uid)
        .updateData(userModel.getMap())
        .then((onValue) {
      return CommonResponseModel(CodeConstants.CODE_SUCCESS, "Success");
    }).catchError((error) {
      return CommonResponseModel(CodeConstants.CODE_EXCEPTION, error.message);
    });
  }

  //  update user profile in db
  Future<CommonResponseModel> updateMode(UserModel userObj) async {
    return Firestore.instance
        .collection(CodeConstants.COLLECTION_USERS)
        .document(userObj.id)
        .updateData(userObj.getMap())
        .then((onValue) {
      if (userObj.rider) {
//            user is rider, remove ride params from active drivers
        return removeRideParams(userObj.id);
      } else {
//              user is driver, add ride params to active drivers
        return addToActiveDrivers(userObj);
      }

//      return CommonResponseModel(CodeConstants.CODE_SUCCESS, "Success");
    }).catchError((error) {
      return CommonResponseModel(CodeConstants.CODE_EXCEPTION, error.message);
    });
  }

//  remove entry from active drivers on rider mode selection
  Future<CommonResponseModel> removeRideParams(String uid) async {
    return Firestore.instance
        .collection(CodeConstants.COLLECTION_ACTIVE_DRIVERS)
        .document(uid)
        .delete()
        .then((onValue) {
      return CommonResponseModel(CodeConstants.CODE_SUCCESS, "Success");
    }).catchError((error) {
      return CommonResponseModel(CodeConstants.CODE_EXCEPTION, error.message);
    });
  }

  Future<CommonResponseModel> addToActiveDrivers(UserModel userObj) async {
    return Firestore.instance
        .collection(CodeConstants.COLLECTION_ACTIVE_DRIVERS)
        .document(userObj.id)
        .setData(userObj.rideParams.getMap())
        .then((onValue) {
      return CommonResponseModel(CodeConstants.CODE_SUCCESS, "Success");
    }).catchError((error) {
      return CommonResponseModel(CodeConstants.CODE_EXCEPTION, error.message);
    });
  }

  Future<CommonResponseModel> updateLocation(
      LocationModel locationModel, String userId) async {
    return Firestore.instance
        .collection(CodeConstants.COLLECTION_ACTIVE_DRIVERS)
        .document(userId)
        .updateData(locationModel.getMap())
        .then((onValue) {
      updateLocationInUsers(locationModel, userId);
      return CommonResponseModel(CodeConstants.CODE_SUCCESS, "Success");
    }).catchError((error) {
      return CommonResponseModel(CodeConstants.CODE_EXCEPTION, error.message);
    });
  }

  Future<CommonResponseModel> updateLocationInUsers(
      LocationModel locationModel, String userId) async {
    UserModel user = commonSingleton.getUserModel();

    user.rideParams.latitude = locationModel.latitude;
    user.rideParams.longitude = locationModel.longitude;

    return Firestore.instance
        .collection(CodeConstants.COLLECTION_USERS)
        .document(userId)
        .updateData(user.getMap())
        .then((onValue) {
      return CommonResponseModel(CodeConstants.CODE_SUCCESS, "Success");
    }).catchError((error) {
      return CommonResponseModel(CodeConstants.CODE_EXCEPTION, error.message);
    });
  }

//  listen for drivers location change and reset listener when map is moved or zoomed
  getDriversByVisibleRegion(
      double leftLongitude, double rightLongitude, HomeBloc homeBloc) {
    if (driversStream != null) {
      driversStream.cancel();
    }

    driversStream = Firestore.instance
        .collection(CodeConstants.COLLECTION_ACTIVE_DRIVERS)
        .where(CodeConstants.FIELD_LONGITUDE,
            isGreaterThan: rightLongitude, isLessThan: leftLongitude)
        .snapshots()
        .listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        print(change.document.data.toString());

        switch (change.type) {
          case DocumentChangeType.added:
            Map<String, RideParamsModel> markers =
                homeBloc.allMarkersController.value;
            RideParamsModel model =
                RideParamsModel.fromJson(change.document.data);

            markers[change.document.documentID] = model;
            homeBloc.allMarkersController.sink.add(markers);

            break;

          case DocumentChangeType.modified:
            Map<String, RideParamsModel> markers =
                homeBloc.allMarkersController.value;
            RideParamsModel model =
                RideParamsModel.fromJson(change.document.data);
            markers[change.document.documentID] = model;
            homeBloc.allMarkersController.sink.add(markers);
            break;

          case DocumentChangeType.removed:
            Map<String, RideParamsModel> markers =
                homeBloc.allMarkersController.value;
            markers.remove(change.document.documentID);
            homeBloc.allMarkersController.sink.add(markers);
            break;
        }
      });
    });
  }

//  create ride
  Future<Object> createRide(RideParamsModel rideParamsModel) async {
    var result = await CloudFunctions.instance
        .getHttpsCallable(functionName: "createRideO-createRide")
        .call({
      "driverNickname": rideParamsModel.nickName,
      "serviceRates": {
        "min_ride_price": rideParamsModel.minRidePrice,
        "min_ride_length": rideParamsModel.minRideLength,
        "next_time_bloc_length": rideParamsModel.nextTimeBlocLength,
        "next_time_bloc_price": rideParamsModel.nextTimeBlocPrice
      },
      "presentmentCurrency": rideParamsModel.currency,
      "presentmentRate": 1,
      "settlementRate": 0.8,
      "location": {
        "latitude": rideParamsModel.latitude,
        "longitude": rideParamsModel.longitude
      }
    });

    return result.data;
  }

//  save card
  Future<Object> saveCard(String cardToken) async {
    var result = await CloudFunctions.instance
        .getHttpsCallable(functionName: "createRideO-saveCard")
        .call({
      "source_id": cardToken,
    });
    return result.data;
  }

//  get and listen for changes in currency rates
  currencyListener(HomeBloc homeBloc) {
    if (currencyStrem != null) {
      currencyStrem.cancel();
    }

    currencyStrem = Firestore.instance
        .collection(CodeConstants.COLLECTION_APPLICATION)
        .snapshots()
        .listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        print(change.document.data.toString());

        switch (change.type) {
          case DocumentChangeType.added:
            if (change.document.documentID == "currency_rates") {
              commonSingleton.currencyModel.value = change.document.data;
              homeBloc.currency.sink.add(change.document.data);
            }

            break;

          case DocumentChangeType.modified:
            Map<String, RideParamsModel> markers =
                homeBloc.allMarkersController.value;
            RideParamsModel model =
                RideParamsModel.fromJson(change.document.data);
            markers[change.document.documentID] = model;
            homeBloc.allMarkersController.sink.add(markers);
            break;

          case DocumentChangeType.removed:
            Map<String, RideParamsModel> markers =
                homeBloc.allMarkersController.value;
            markers.remove(change.document.documentID);
            homeBloc.allMarkersController.sink.add(markers);
            break;
        }
      });
    });
  }
}
