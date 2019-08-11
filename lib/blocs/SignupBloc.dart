import 'dart:async';

import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:teleport/common_utils/CodeConstants.dart';
 import 'package:teleport/common_utils/SharedPref.dart';
import 'package:teleport/models/CommonResponseModel.dart';
import 'package:teleport/models/RideParamsModel.dart';
import 'package:teleport/models/UserModel.dart';
import 'package:teleport/network/Repository.dart';
import 'package:teleport/ui/widgets/ErrorDialog.dart';
import 'package:validators/validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ui/pages/functionality/Home.dart';
import 'CommonSingleton.dart';
import 'BlocBase.dart';

class SignUpBloc extends BlocBase {
  final repository = Repository();

  AppLocalizations al;

  SignUpBloc(this.al) {
    isLoadingController.sink.add(false);
  }

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();
  final isLoadingController = BehaviorSubject<bool>();

  Observable<String> get email =>
      _emailController.stream.transform(validateEmail);

  Observable<bool> get isloading => isLoadingController.stream;

  Observable<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Observable<String> get confirmPassword => _confirmPasswordController.stream;

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  Function(String) get changeConfirmPassword =>
      _confirmPasswordController.sink.add;

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@') & email.contains('.') & isEmail(email)) {
      sink.add(email);
    } else {
      sink.addError(CodeConstants.invalidEmailMessage);
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 5) {
      sink.add(password);
    } else {
      sink.addError(password.length == 0
          ? CodeConstants.emptyPasswordMessage
          : CodeConstants.passwordValidateMessage);
    }
  });

  String emailValidator(String inputValue) {
    if (inputValue.isEmpty) {
      return al.tr("error.emptyField");
    }

    if (!inputValue.contains('@') && !inputValue.contains('.')) {
      return al.tr("error.invalidEmail");
    }
    return null;
  }

  String passwordValidator(String inputValue) {
    if (inputValue.length < 5) {
      return al.tr("error.passwordLength");
    }
    return null;
  }

  String confirmPasswordValidator(String inputValue) {
    print(_passwordController.value);
    if (_passwordController.value != inputValue) {
      return al.tr("error.passwordConfirmPassword");
    }
    return null;
  }

  void registerViaEmail(GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) async {
    if (formKey.currentState.validate()) {
      isLoadingController.sink.add(true);
      var userObj = UserModel();
      formKey.currentState.save();
      userObj.email = _emailController.value;
      userObj.password = _passwordController.value;
      userObj.rider = true;

      RideParamsModel rideParamsModel = RideParamsModel();
      rideParamsModel.minRideLength = "10";
      rideParamsModel.minRidePrice = "10";
      rideParamsModel.nextTimeBlocLength = "10";
      rideParamsModel.nextTimeBlocPrice = "10";
      rideParamsModel.currency = "USD";
      userObj.rideParams = rideParamsModel;

      CommonResponseModel response = await registerUser(context, userObj);

      if (response.code != CodeConstants.CODE_SUCCESS) {
        isLoadingController.sink.add(false);
        ErrorDialog(
          context,
          response.data,
        );
      } else {
        userObj.id = response.data;
        repository.signUp(userObj).then((onValue) {
          if (onValue.code == CodeConstants.CODE_SUCCESS) {
            isLoadingController.sink.add(false);
            userObj.id = onValue.data;
            navigateToHome(context, userObj);
          } else {
            isLoadingController.sink.add(false);
            ErrorDialog(
              context,
              onValue.data,
            );
          }
        });
      }
    }
  }

  Future<CommonResponseModel> registerUser(
      BuildContext context, UserModel userObj) {
    return repository.registerViaEmail(userObj);
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    isLoadingController.close();
    _confirmPasswordController.close();
  }

  void navigateToHome(context, UserModel userObj) {
    SharedPref().save(CodeConstants.USER, userObj.toString()).then((user) {
      SharedPref().save(CodeConstants.USER_ID, userObj.id).then((uid) {
        commonSingleton.updateProfile(userObj);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Home()),
            (_) => false);
      });
    });
  }
}
