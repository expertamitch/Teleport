import 'dart:convert';

import 'package:frideos_core/frideos_core.dart';
import 'package:teleport/common_utils/CodeConstants.dart';
import 'package:teleport/common_utils/SharedPref.dart';
import 'package:teleport/models/RideParamsModel.dart';
import 'package:teleport/models/UserModel.dart';
import 'package:teleport/network/Repository.dart';

class CommonSingleton {
  final repository = Repository();

  static final CommonSingleton _singletonBloc = new CommonSingleton._internal();

  final token = StreamedValue<String>();
  final currencyModel = StreamedValue<Map<String, dynamic>>();

  final id = StreamedValue<String>();
  final email = StreamedValue<String>();
  final firstName = StreamedValue<String>();
  final lastName = StreamedValue<String>();
  final nickName = StreamedValue<String>();
  final phoneNumber = StreamedValue<String>();
  final image = StreamedValue<String>();
  final rider = StreamedValue<bool>();

  final currency = StreamedValue<String>();
  final minPrice = StreamedValue<String>();
  final minLength = StreamedValue<String>();
  final nextBlocPrice = StreamedValue<String>();
  final nextBlocLength = StreamedValue<String>();

  factory CommonSingleton() {
    return _singletonBloc;
  }

  updateProfile(UserModel userObj) {
    if (userObj.id != null) {
      id.value = userObj.id;
    }
    if (userObj.nickName != null) {
      nickName.value = userObj.nickName;
    }

    if (userObj.firstName != null) {
      firstName.value = userObj.firstName;
    }
    if (userObj.lastName != null) {
      lastName.value = userObj.lastName;
    }

    if (userObj.email != null) {
      email.value = userObj.email;
    }

    if (userObj.phoneNumber != null) {
      phoneNumber.value = userObj.phoneNumber;
    }

    if (userObj.image != null) {
      image.value = userObj.image;
    }

    if (userObj.rider != null) {
      rider.value = userObj.rider;
    }

    if (userObj.rideParams != null) {
      updateRideParams(userObj.rideParams);
    }

    profileDefaults();
  }

  profileDefaults() {
    if (id.value == null) {
      id.value = "";
    }
    if (nickName.value == null) {
      nickName.value = "";
    }

    if (firstName.value == null) {
      firstName.value = "";
    }
    if (lastName.value == null) {
      lastName.value = "";
    }

    if (email.value == null) {
      email.value = "";
    }

    if (phoneNumber.value == null) {
      phoneNumber.value = "";
    }

    if (image.value == null) {
      image.value = "";
    }

    if (rider.value == null) {
      rider.value = true;
    }
  }

  updateRideParams(RideParamsModel rideParamsModel) {
    if (rideParamsModel.nickName != null) {
      nickName.value = rideParamsModel.nickName;
    }

    if (rideParamsModel.currency != null) {
      currency.value = rideParamsModel.currency;
    }
    if (rideParamsModel.minRideLength != null) {
      minLength.value = rideParamsModel.minRideLength;
    }
    if (rideParamsModel.minRidePrice != null) {
      minPrice.value = rideParamsModel.minRidePrice;
    }
    if (rideParamsModel.nextTimeBlocLength != null) {
      nextBlocLength.value = rideParamsModel.nextTimeBlocLength;
    }
    if (rideParamsModel.nextTimeBlocPrice != null) {
      nextBlocPrice.value = rideParamsModel.nextTimeBlocPrice;
    }

    rideParamDefaults();
  }

  rideParamDefaults() {
    if (currency.value == null) {
      currency.value = "";
    }
    if (minLength.value == null) {
      minLength.value = "";
    }

    if (minPrice.value == null) {
      minPrice.value = "";
    }
    if (nextBlocLength.value == null) {
      nextBlocLength.value = "";
    }

    if (nextBlocPrice.value == null) {
      nextBlocPrice.value = "";
    }
  }

  UserModel getUserModel() {
    UserModel userModel = UserModel();

    userModel.id = id.value;
    userModel.email = email.value;
    userModel.firstName = firstName.value;
    userModel.lastName = lastName.value;
    userModel.nickName = nickName.value;
    userModel.phoneNumber = phoneNumber.value;
    userModel.image = image.value;
    userModel.rider = rider.value;

    userModel.rideParams = RideParamsModel();

    userModel.rideParams.currency = currency.value;
    userModel.rideParams.minRidePrice = minPrice.value;
    userModel.rideParams.minRideLength = minLength.value;
    userModel.rideParams.nextTimeBlocPrice = nextBlocPrice.value;
    userModel.rideParams.nextTimeBlocLength = nextBlocLength.value;

    return userModel;
  }

  Future<String> saveLocal(UserModel userObj) {
    return SharedPref()
        .save(CodeConstants.USER, userObj.toString())
        .then((res) {
      return "";
    });
  }

  CommonSingleton._internal();

  dispose() {
    print('Disposing bloc');
    id.dispose();
    email.dispose();
    firstName.dispose();
    lastName.dispose();
    nickName.dispose();
    phoneNumber.dispose();
    image.dispose();
    rider.dispose();
  }

  String getConvertedCurrency(String code, double minRidePrice) {
    Map<String, dynamic> json = currencyModel.value;

    Map<String, dynamic> rates = JsonCodec().decode(json['rates']);
    Map<String, dynamic> ratesX = rates['rates'];

//    currency value of driver/rider
    double otherCurrency = double.parse(ratesX[code].toString());

    //    currency value of driver/rider
    double mineCurrency = double.parse(ratesX[currency.value].toString());

//    first convert otherCurrency to usd, 5/60, where 5 is minRidePrice and 60 is 1USD = otherCurrency(60)

    double otherUsdAmount = minRidePrice / otherCurrency;


    double mineAmount=otherUsdAmount*mineCurrency;

    return mineAmount.toStringAsFixed(2);
  }
}

final commonSingleton = CommonSingleton();
