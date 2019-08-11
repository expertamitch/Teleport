import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:teleport/common_utils/CodeConstants.dart';
import 'package:teleport/common_utils/SharedPref.dart';
import 'package:teleport/models/UserModel.dart';
import 'package:teleport/network/Repository.dart';
import 'package:teleport/ui/widgets/ErrorDialog.dart';
import 'CommonSingleton.dart';
import 'package:teleport/ui/pages/auth/Login.dart';

import 'BlocBase.dart';

class SettingsBloc extends BlocBase {
  final repository = Repository();

  SettingsBloc() {
    isLoadingController.sink.add(false);
  }

  final isLoadingController = BehaviorSubject<bool>();

  Observable<bool> get isloading => isLoadingController.stream;

  logout(context) {
    isLoadingController.sink.add(true);
    repository.logout().then((onValue) {
      if (onValue.code == CodeConstants.CODE_SUCCESS) {
        SharedPref().clear().then((done) {
          if (done) {
            navigateToLogin(context);
          }
        });
      } else {
        ErrorDialog(
          context,
          onValue.data,
        );
      }
    });
  }

  @override
  void dispose() {
    isLoadingController.close();
  }

  updateProfile(bool rider, BuildContext context) {
    var user = commonSingleton.getUserModel();
    user.rider = rider;
    repository.updateMode(user).then((res) {
      if (res.code == CodeConstants.CODE_SUCCESS) {
        UserModel userModel = commonSingleton.getUserModel();
        userModel.rider = rider;

        commonSingleton.saveLocal(userModel).then((res) {
          commonSingleton.updateProfile(userModel);
        });
      } else {
        ErrorDialog(context, res.data);
      }
    });
  }

  void navigateToLogin(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => Login()),
        (_) => false);
  }
}
